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
prepare_workspace
check_context "${cluster_config_context}"
# check_args "$@"
## Header End
## Docs Start ##
## Imports secrets. Args: namespace filter
## Docs End ##

log_debug "${project_name} - Imports existing secrets"

namespaceToImport=$1
filter=${2:-""}

log_debug "Helm Release Secrets will not be included!"

if [[ "${filter}" != "" ]]
then
    secrets=$(kubectl get secrets -n ${namespaceToImport} --no-headers | grep -v "helm.release.v1" | grep ${filter} | awk '{print $1}')
else
    secrets=$(kubectl get secrets -n ${namespaceToImport} --no-headers | grep -v "helm.release.v1" | awk '{print $1}')
fi

while read s
do
    log_info "Importing Secret: ${namespaceToImport}/${s}"
    targetFolder="${secrets_path}/imported/${namespaceToImport}"

    mkdir -p ${targetFolder}

    kubectl get secrets -n ${namespaceToImport} -o yaml ${s} | \
    yq eval --prettyPrint -o json | \
     jq 'del(.metadata.ownerReferences)' | \
     jq 'del(.metadata.managedFields)' | \
     jq 'del(.metadata.uid)' | \
     jq 'del(.metadata.resourceVersion)' | \
     jq 'del(.metadata.selfLink)' | \
     jq 'del(.metadata.creationTimestamp)' | \
     jq '. + {"stringData": .data | map_values(@base64d)} | del(.data)' | \
     yq eval -P > ${targetFolder}/${s}.yaml

done <<< "${secrets}"

log_info "Done importing secrets at: ${secrets_path}/imported"
