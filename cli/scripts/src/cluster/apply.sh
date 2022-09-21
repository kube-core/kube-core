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
check_args "$@"
## Header End
## Docs Start ##
## Applies cluster config (everything)
## Docs End ##


log_info "${cluster_config_name} - Applying cluster config ..."

configPath=${config_path}
localPath=${localConfig_path}

if [[ "${install_type}" == "helmfile" ]]
then

    # Applying CRDs
    # For now applying CRDs is disabled by default to mirror build behavior. Use --include-crds to apply them.
    # TODO: Consider if we should activate it by default.
    # At the moment, not seen as a good practice, as CRDs operations can be destructive.
    if [[ "${includeCRDs}" == "yes" ]]; then
        ${scripts_cluster_apply_crds_path} $@
    fi

    # Applying namespaces
    ${scripts_cluster_apply_namespaces_path} $@

    # Applying ConfigMaps
    ${scripts_cluster_apply_configmaps_path} $@

    # Applying Secrets
    # For now applying Secrets is disabled by default to mirror build behavior. Use --include-secrets to apply them.
    # TODO: Consider if we should activate it by default.
    # At the moment, not seen as a good practice, as Secrets operations can be destructive.
    if [[ "${includeSecrets}" == "yes" ]]; then
        ${scripts_cluster_apply_secrets_path} $@
    fi

    # Helmfile Releases
    ${scripts_cluster_apply_helmfiles_path} $@

    # Applying local config
    ${scripts_cluster_apply_config_path} $@


    # TODO: Custom apply
    # ${clusterConfigDirPath}/generate-custom.sh || true
fi

log_info "${cluster_config_name} - Done applying cluster config !"
