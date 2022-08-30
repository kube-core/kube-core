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
corePath=$(echo ${scriptsConfigDirPath}/.. | xargs realpath)
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

# set -x
# Loading scripts-config.yaml
paths=$(parse_yaml ${scriptsConfigPath})
absolutePaths=$(echo "${paths}" | sed "s|\./|${scriptsConfigDirPath}/|")
eval "${absolutePaths}"

# exit 0

check_requirements
prepare_workspace
check_context "${cluster_config_context}"
check_args "$@"
## Header End



log_info "Building cluster manifests..."

configPath=${config_path}
localPath=${localConfig_path}

# By default, applies patches & doesn't regenerate secrets
# arg1=${1:-"none"}
# arg2=${2:-"none"}
# arg3=${3:-"patch"}

# commandArgs="${arg1} ${arg2} ${arg3}"

# Deleting the config first.
# This makes sure we can handle resource deletion, and prevents direct modification of config folder.

if [[ ${filter} != "" || ${helmfileSelector} != "" || ${helmfileSelectorOverride} != "" ]]; then
    log_debug "Using filter. Not deleting anything."
else
    log_debug "No filter. Deleting everything first..."
    rm -rf ${configPath}
fi

# Generating manifests from helmfiles
${scripts_gitops_helmfile_path} $@

# Generating manifests from local config
${scripts_gitops_gitops_path} $@

# Cleaning up some stuff
# TODO: Reimplement
# ${scripts_gitops_cleanup_path}

# Runs some post-processing on all manifests.
${scripts_cluster_process_path} $@

# Restoring all secrets.
# This forces to handle secrets separately. Any non-commited modification to secrets will be reverted.
${scripts_gitops_restore_secrets_path}

# Generating a lockfile for our config.
get_config ${config_path} | sed "s|${clusterConfigDirPath}|.|" | sort -u > ${clusterConfigDirPath}/gitops-config.lock

# TODO: Use this instead when hash support will be needed
# rm -rf gitops-config.lock
# get_config ${config_path} | sed "s|${clusterConfigDirPath}|.|" | sort -u | xargs -i sha256sum '{}' >> ${clusterConfigDirPath}/gitops-config.lock

log_info "Done Building cluster manifests!"
