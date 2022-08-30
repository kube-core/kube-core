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


echo "Linting all charts..."

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


list="$(find ${coreReleasesPath}/dist/releases/crds/* -maxdepth 0 -type d)" || true
list="${list}
$(find ${coreReleasesPath}/dist/releases/charts/* -maxdepth 0 -type d)" || true

filter=${1:-""}

if [[ "$filter" != "" ]] ; then
  list=$(echo "${list}" | grep ${filter}) || true
fi

if [[ ! -z "${list}" ]] ; then
# Looping through releases
echo "${list}" | while read releasePath;
do
    helm lint ${releasePath} -f ${corePath}/core/envs/default/cluster.yaml
done
fi
echo "Done linting !"