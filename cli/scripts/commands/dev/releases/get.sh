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
corePath=$(echo ${scriptsConfigDirPath}/.. | xargs realpath)
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

filter=${1:-""}

echo "### get.sh - start"
# Setting up folders for CRDs generation
mkdir -p ${baseReleasesFolder}

# Setting up folders for CRDs generation
mkdir -p ${releasesGeneratedCrdsFolder}

# Setting up folders for post processed release
mkdir -p ${releasesProcessedFolder}


if [[ "$filter" != "" ]] ; then
    vendirContents=$(cat ${corePath}/vendir-releases.yaml | yq e 'del(.directories[].contents[] | select(.path != "*'${filter}'*"))') || true
else
    vendirContents=$(cat ${corePath}/vendir-releases.yaml)
fi

# Prepare vendir file
echo "${vendirContents}" > ${tmpReleasesFolder}/vendir-releases.yaml

# Getting releases with vendir
vendir sync -f "${tmpReleasesFolder}/vendir-releases.yaml" --chdir ${tmpReleasesFolder} --tty --lock-file ${corePath}/vendir.lock.yaml

# echo "Done, fetching releases!"
# echo "### get.sh - end"
