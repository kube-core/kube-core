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

tmpConfigPath=${tmpFolder}/config


log_debug "Generating namespaces..."
arg=${1:-""}
# TODO: Include this logic directly in kube-core build namespaces
# Requires to handle the cases: if running in kube-core build all or independently, and if the project is at initial setup stage or later update
if [[ "$arg" == "with-helmfile" ]]; then
    log_warn "Using only helmfile list to build namespaces"
    filter=""
    helmfileSelector=""
    helmfileSelectorOverride=""
    namespaces=$(helmfile_list | awk '{print $2}' | tail -n +2 | sort -u)
    mkdir -p ${config_path}/namespace
    while read namespace; do
cat <<YAML > ${config_path}/namespace/${namespace}.yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: ${namespace}
YAML
    done <<< "${namespaces}"
    log_debug "Done Generating namespaces!"
    mkdir -p ${config_path}/namespace
    cat <<YAML > ${config_path}/namespace/secrets.yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: secrets
YAML
    exit
fi

find ${tmpConfigPath} -mindepth 1 -maxdepth 1 -type d | while read namespacePath; do
    namespace=$(basename $namespacePath)
    # add namespace creation
if [[ ! -e ${namespacePath}/namespace.yaml && "${namespace}" != "namespace" ]]; then
cat <<YAML > ${namespacePath}/namespace.yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: ${namespace}
YAML
fi
done

mkdir -p ${tmpConfigPath}/namespace
cat <<YAML > ${tmpConfigPath}/namespace/secrets.yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: secrets
YAML

log_debug "Done Generating namespaces!"
