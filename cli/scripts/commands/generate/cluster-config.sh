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
if [[ -z "${clusterConfigPath}" ]] ; then
    echo "Stopping ${currentScript}"
    echo "This script requires to be in a cluster context, but cluster-config.yaml not found in parent directories"
    exit 0
fi

clusterConfigDirPath=$(dirname ${clusterConfigPath} | xargs realpath)
helmfilePath="${clusterConfigDirPath}/helmfile.yaml"
tmpFolder="${clusterConfigDirPath}/.kube-core/.tmp"

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

# Loading default-cluster-config.yaml
clusterConfigVars=$(parse_yaml ${defaultClusterConfigPath})
clusterConfigVars=$(echo "${clusterConfigVars}" | sed "s|\./|${clusterConfigDirPath}/|")
eval "${clusterConfigVars}"

# Loading cluster-config.yaml
clusterConfigVars=$(parse_yaml ${clusterConfigPath})
clusterConfigVars=$(echo "${clusterConfigVars}" | sed "s|\./|${clusterConfigDirPath}/|")
eval "${clusterConfigVars}"

# Loading scripts-config.yaml
paths=$(parse_yaml ${scriptsConfigPath})
absolutePaths=$(echo "${paths}" | sed "s|\./|${scriptsConfigDirPath}/|")
eval "${absolutePaths}"

check_requirements
# check_context "${cluster_config_context}"
# check_args "$@"
## Header End
## Docs Start ##
## Generates cluster-config.yaml from helmfile env. Wrapped by CLI: kube-core cluster setup config
## Docs End ##

valuesFolder="${tmpFolder}/values"
generatedValuesFolder="${valuesFolder}/generated"
allValuesFile="${valuesFolder}/all-values.yaml"

mkdir -p ${generatedValuesFolder}

# if [[ ! -f "${allValuesFile}" ]]; then
helmfile -f ${helmfilePath} build | yq e -N -P 'select(di == 0) | .renderedvalues' - > ${allValuesFile}
# fi

rm -rf ${clusterConfigPath}
echo "# Config generated with kube-core generate:cluster-config." >> ${clusterConfigPath}
echo "# Do not edit directly, edit kube-core values and generate again instead!" >> ${clusterConfigPath}
cat ${allValuesFile} | yq e '.project | { "project": . }' - >> ${clusterConfigPath}
cat ${allValuesFile} | yq e '.git | { "git": . }' - >> ${clusterConfigPath}
cat ${allValuesFile} | yq e '.gitops | { "gitops": . }' - >> ${clusterConfigPath}
cat ${allValuesFile} | yq e '.cloud | { "cloud": . }' - >> ${clusterConfigPath}
cat ${allValuesFile} | yq e '.cluster | { "cluster": . }' - >> ${clusterConfigPath}
cat ${allValuesFile} | yq e '.helmfile | { "helmfile": . }' - >> ${clusterConfigPath}
cat ${allValuesFile} | yq e '.run | { "run": . }' - >> ${clusterConfigPath}
