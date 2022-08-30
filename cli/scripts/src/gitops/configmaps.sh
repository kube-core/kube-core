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


log_info "Building: local/configmaps -> config/namespace/configmaps..."

tmpConfigPath=${tmpFolder}/config
configPath=${tmpConfigPath}
localConfigPath=${localConfig_path}
buildPath=${build_path}

configMapsPath=${configmaps_path}/output
replicatedConfigMapsPath=${configmaps_path}/replicated

log_debug "Generating configmaps..."
${scripts_k8s_configmaps_generate_path} $@

log_debug "Copying configmaps..."

mkdir -p ${configMapsPath}
mkdir -p ${replicatedConfigMapsPath}
mkdir -p ${configPath}
rm -rf ${tmpFolder}/configmaps
mkdir -p ${tmpFolder}/configmaps

cd ${configMapsPath} &> /dev/null # Remove logs
configmaps=$(find . -type f -name '*.yaml')
echo "${configmaps}" | xargs yq '.' > ${tmpFolder}/configmaps/configmaps.yaml


cd ${replicatedConfigMapsPath} &> /dev/null # Remove logs
replicatedConfigMaps=$(find . -type f -name '*.yaml')
echo "${replicatedConfigMaps}" | xargs yq '.' > ${tmpFolder}/configmaps/replicated-configmaps.yaml


if [[ "$LOG_LEVEL" == "DEBUG" || "$LOG_LEVEL" == "INSANE" ]] ; then
    if [[ ! -z "${configmaps}" ]] ; then
        kubectl slice -f ${tmpFolder}/configmaps/configmaps.yaml --output-dir ${tmpFolder}/configmaps/configmaps --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'
    fi
    if [[ ! -z "${replicatedConfigMaps}" ]] ; then
        kubectl slice -f ${tmpFolder}/configmaps/replicated-configmaps.yaml --output-dir ${tmpFolder}/configmaps/configmaps --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'
    fi
else
    if [[ ! -z "${configmaps}" ]] ; then
        kubectl slice -f ${tmpFolder}/configmaps/configmaps.yaml --output-dir ${tmpFolder}/configmaps/configmaps --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml' 2> /dev/null
    fi
    if [[ ! -z "${replicatedConfigMaps}" ]] ; then
        kubectl slice -f ${tmpFolder}/configmaps/replicated-configmaps.yaml --output-dir ${tmpFolder}/configmaps/configmaps --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml' 2> /dev/null
    fi
fi

cp -fr ${tmpFolder}/configmaps/configmaps/* ${configPath} 2>/dev/null || true

# mkdir -p ${configPath}/configmaps
# cp -rf ${configMapsPath}/* ${configPath} 2>/dev/null || true

# TODO: Implement replicated for configmaps
# cp -nr ${replicatedConfigMapsPath}/* ${configPath}

log_info "Done Building: local/configmaps -> config/namespace/configmaps..."
