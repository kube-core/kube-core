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



log_debug "${project_name} - Installing SealedSecrets"


if [[ "${install_type}" == "helmfile" ]]
then
    echo "WARNING: This step is done with helmfile !"
    echo "WARNING: Not compatible with GitOps, only use in dev !"
    echo "Using Helmfile to install sealed-secrets"
    cd ${clusterConfigDirPath}
    helmfile -f ${helmfilePath} -l name=sealed-secrets apply
    echo "SealedSecrets installed with helmfile !"
fi


if [[ "${install_type}" == "gitops" ]]
then
    echo "Generating sealed-secrets manifests"
    cd ${clusterConfigDirPath}
    ${scripts_gitops_helmfile_path} "-l name=sealed-secrets"
    ${scripts_gitops_utils_generate_namespaces_path}
    echo "SealedSecrets manifests & namespace generated. You can push them to GitOps !"
fi


if [[ "${install_type}" == "gitops-ssa" ]]
then
    echo "Generating sealed-secrets manifests"
    cd ${clusterConfigDirPath}
    ${scripts_gitops_helmfile_path} "-l name=sealed-secrets"
    ${scripts_gitops_utils_generate_namespaces_path}

    echo "Using SSA to apply manifests..."
    echo "WARNING: gitops-ssa mode is dummy, using --server-side --dry-run=server !"
    echo "WARNING: If you wish to use SSA, for now use it manually with the following command:"
    echo "kubectl apply -R -f ${config_path}/sealed-secrets --server-side"

    kubectl apply -R -f ${config_path}/sealed-secrets --server-side --dry-run=server

    echo "SealedSecrets manifests & namespace generated. Applied with SSA (dry-run) !"
fi
