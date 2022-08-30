#!/bin/bash
set -eou pipefail

## Header Start

# Current Script
currentScript=${BASH_SOURCE[0]}
currentScriptPath="$( cd "$( dirname "${currentScript}" )" >/dev/null 2>&1 && pwd )"
currentScriptShortPath=$(echo "${currentScriptPath}" | awk '{split($0, a, "/scripts/"); print a[2]}')

# Cluster Config
if [[ ! -z $(find ./cluster-config.yaml 2> /dev/null) ]]; then
    clusterConfigPath=$(echo ./cluster-config.yaml | head -n 1 | xargs realpath 2> /dev/null)
else
    clusterConfigPath=$(eval find ./$(printf "{$(echo %{1..7}q,)}" | sed 's/ /\.\.\//g') -maxdepth 1 -name cluster-config.yaml | head -n 1 | xargs realpath 2> /dev/null) || true
fi
# if [[ -z "${clusterConfigPath}" ]] ; then
#     echo "Stopping ${currentScript}"
#     echo "This script requires to be in a cluster context, but cluster-config.yaml not found in parent directories"
#     exit 0
# fi

# clusterConfigDirPath=$(dirname ${clusterConfigPath} | xargs realpath)
# helmfilePath="${clusterConfigDirPath}/helmfile.yaml"
# tmpFolder="${clusterConfigDirPath}/.kube-core/.tmp"

# Cluster Scripts
if [[ ! -z $(find ${currentScriptPath}/scripts-config.yaml 2> /dev/null) ]]; then
    scriptsConfigPath=$(echo ${currentScriptPath}/scripts-config.yaml | head -n 1 | xargs realpath 2> /dev/null)
else
    scriptsConfigPath=$(eval find "${currentScriptPath}"/$(printf "{$(echo %{1..7}q,)}" | sed 's/ /\.\.\//g') -maxdepth 1 -name scripts-config.yaml | head -n 1 | xargs realpath)
fi
scriptsConfigDirPath=$(dirname ${scriptsConfigPath} | xargs realpath)

defaultClusterConfigPath=${scriptsConfigDirPath}/default-cluster-config.yaml
corePath=$(echo ${scriptsConfigDirPath}/../.. | xargs realpath)
coreTmpFolder="${corePath}/.kube-core/.tmp"

# Loading scripts
eval "$(${scriptsConfigDirPath}/src/includes.sh)"

# # Loading default-cluster-config.yaml
# clusterConfigVars=$(parse_yaml ${defaultClusterConfigPath})
# clusterConfigVars=$(echo "${clusterConfigVars}" | sed "s|\./|${clusterConfigDirPath}/|")
# eval "${clusterConfigVars}"

# # Loading cluster-config.yaml
# clusterConfigVars=$(parse_yaml ${clusterConfigPath})
# clusterConfigVars=$(echo "${clusterConfigVars}" | sed "s|\./|${clusterConfigDirPath}/|")
# eval "${clusterConfigVars}"

# Loading scripts-config.yaml
paths=$(parse_yaml ${scriptsConfigPath})
absolutePaths=$(echo "${paths}" | sed "s|\./|${scriptsConfigDirPath}/|")
eval "${absolutePaths}"

check_requirements
# check_context "${cluster_config_context}"
# check_args "$@"
## Header End


releasesPath="${corePath}/core/envs/core/releases"

coreReleasesPath=${corePath}/releases

tmpReleasesFolder=${coreTmpFolder}/releases
baseReleasesFolder=${tmpReleasesFolder}/releases/base
releasesCrdsFolder=${tmpReleasesFolder}/releases/crds
releasesGeneratedCrdsFolder=${tmpReleasesFolder}/releases-crds
releasesProcessedFolder=${tmpReleasesFolder}/releases-processed

mkdir -p ${coreReleasesPath}/dist/releases/
mkdir -p ${coreReleasesPath}/dist/releases/crds
mkdir -p ${coreReleasesPath}/dist/releases/charts
mkdir -p ${coreReleasesPath}/dist/releases/base

mkdir -p ${coreReleasesPath}/dist/manifests/crds

list="$(find ${baseReleasesFolder}/* -maxdepth 0 -type d)"

filter=${1:-""}


if [[ "$filter" != "" ]] ; then
  list=$(echo "${list}" | grep ${filter}) || true
fi

if [[ ! -z "${list}" ]] ; then

# Looping through releases
echo "${list}" | while read releasePath;
do
    releaseName=$(echo "${releasePath}" | xargs basename)
    # baseRelease=$(echo "${releaseName}" | sed -E 's/\-crds$//')
    releaseCRDsPath=${releasesGeneratedCrdsFolder}/${releaseName}
    releaseProcessedPath=${releasesProcessedFolder}/${releaseName}
    crdsTmpFolder=${releaseCRDsPath}/tmp
    processedTmpFolder=${releaseProcessedPath}/tmp
    templateOutput="${crdsTmpFolder}/all.yaml"

    echo "${releaseName} - CRDs"
    mkdir -p ${releaseCRDsPath}
    cp -rf ${releasePath}/* ${releaseCRDsPath} &> /dev/null || true
    mkdir -p ${crdsTmpFolder}

    rm -rf ${releaseCRDsPath}/templates/*
    rm -rf ${releaseCRDsPath}/charts
    rm -rf ${releaseCRDsPath}/crds
    rm -rf ${releaseCRDsPath}/ci
    rm -rf ${releaseCRDsPath}/OWNERS
    rm -rf ${releaseCRDsPath}/README.md

    # Generating CRDs
    helm template --include-crds ${releasePath} --set crd.create=true --set installCRDs=true --set kps-robusta.clusterName="default" --set kps-robusta.enableServiceMonitors=true \
    -f ${corePath}/core/envs/default/cluster.yaml \
    -f ${corePath}/core/envs/default/core.yaml \
    > ${templateOutput}
    kubectl slice --template '{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml' --output-dir ${crdsTmpFolder}/generated -f ${templateOutput} &> /dev/null

    # Packing the chart properly
    if [[ -d ${crdsTmpFolder}/generated/customresourcedefinition ]]; then
        # Moving CRD files
        mkdir -p ${releaseCRDsPath}/templates/
        cp -rf ${crdsTmpFolder}/generated/customresourcedefinition/* ${releaseCRDsPath}/templates/ &> /dev/null || true

        # Copying CRDs to dist before cleanup
        # TODO: Fix some duplicate CRDs in manifests (maybe using kubectl slice once more?)

        cp -rf ${crdsTmpFolder}/generated/customresourcedefinition/* ${coreReleasesPath}/dist/manifests/crds
        rm -rf ${templateOutput} ${crdsTmpFolder}

        # Removing Dependencies as we have a fresh chart just for CRDs
        cat ${releaseCRDsPath}/Chart.yaml | yq e 'del(.dependencies)' - > ${releaseCRDsPath}/Chart.yaml.out
        cp -f ${releaseCRDsPath}/Chart.yaml.out ${releaseCRDsPath}/Chart.yaml &> /dev/null || true
        rm -rf ${releaseCRDsPath}/Chart.yaml.out

    else
        rm -rf ${releaseCRDsPath}
    fi

    ###

    echo "${releaseName} - Processed"
    mkdir -p ${releaseProcessedPath}
    cp -rf ${releasePath}/* ${releaseProcessedPath}
    mkdir -p ${processedTmpFolder}

    # Detecting CRDs and removing them
    rm -rf ${releaseProcessedPath}/crds
    filesList=$(grep -r -l -E 'kind: CustomResourceDefinition' ${releaseProcessedPath})
    if [[ ! -z "${filesList}" ]]; then
        echo "${filesList}" | xargs realpath | xargs rm -rf
    fi
    rm -rf ${releaseProcessedPath}/templates/crds.yaml
    rm -rf ${releaseProcessedPath}/templates/crd.yaml
    rm -rf ${processedTmpFolder}

done || true

cp -rf ${releasesCrdsFolder}/*  ${releasesGeneratedCrdsFolder} &> /dev/null || true
cp -rf ${releasesGeneratedCrdsFolder}/* ${coreReleasesPath}/dist/releases/crds &> /dev/null || true
cp -rf ${releasesProcessedFolder}/* ${coreReleasesPath}/dist/releases/charts
cp -rf ${baseReleasesFolder}/* ${coreReleasesPath}/dist/releases/base

# find ${coreReleasesPath}/dist/releases/ -type f -name '.helmignore' | xargs rm -rf

fi
echo "Done building releases!"
