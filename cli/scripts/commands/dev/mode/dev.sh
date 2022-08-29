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


releasesPath="${corePath}/core/envs/default/core/releases"
coreReleasesPath=${corePath}/releases

# cat ${corePath}/envs/default/core/releases/releases.yaml | sed 's|../releases/dist/releases/charts/|../releases/local/|'
localReleases=$(cat ${corePath}/vendir-releases.yaml | grep "/releases/local/" | awk '{ print $2}' | awk -F/ '{print $NF}')


echo "Linking local kube-core releases for development..."

echo "${localReleases}" | while read release; do
    sed -i "s|../releases/.*/${release}|../releases/local/${release}|" ${corePath}/core/envs/default/core/releases/releases.yaml
done || true

templatedReleases=$( grep -Erl "../releases/(dist|local)" ${corePath}/core/templates/)
releasesList=$(echo "${templatedReleases}" | while read release; do
    releaseName="$(cat ${release} | grep "chart:"  | awk '{ print $2}' | awk -F/ '{print $NF}')"
    echo "${releaseName}"
done || true)

# echo "${releasesList}" | sort -u 

echo "${templatedReleases}" | while read template; do
    echo "${releasesList}" | sort -u | while read release; do
        if grep -q ${release} ${template}; then
            if echo "${localReleases}" | grep -q ${release}; then
                sed -i "s|../releases/.*/${release}|../releases/local/${release}|" ${template}         
            fi
        fi
    done
done


echo "Done linking !"