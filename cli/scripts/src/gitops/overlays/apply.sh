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
## Applies Core and Cluster Overlays on the config
## Docs End ##

log_info "Applying Overlays..."

configPath=${config_path}
overlaysPath=${overlays_path}

if [[ "${run_core_overlays}" == "true" ]]; then
coreOverlaysList=$(find ${currentScriptPath} -type f -name '*.yaml')

if [[ "${coreOverlaysList}" != "" ]]; then
    log_info "Applying Core Overlays..."
    while read overlay; do
        log_debug "Applying overlay: ${overlay}"
        if [[ "$LOG_LEVEL" == "DEBUG" || "$LOG_LEVEL" == "INSANE" ]]; then
            echo "ytt --ignore-unknown-comments --output-files ${configPath}-f ${configPath}-f ${overlay}"
            ytt --ignore-unknown-comments \
                --output-files ${configPath} \
                -f ${configPath} \
                -f ${overlay}
        else
            ytt --ignore-unknown-comments \
                --output-files ${configPath} \
                -f ${configPath} \
                -f ${overlay} > /dev/null
        fi
    done <<< "${coreOverlaysList}"
else
    log_warn "No Core Overlay found!"
fi
fi

if [[ "${run_cluster_overlays}" == "true" ]]; then
clusterOverlaysList=$(find ${overlaysPath} -type f -name '*.yaml')

if [[ "${clusterOverlaysList}" != "" ]]; then
    log_info "Applying Cluster Overlays..."
    while read overlay; do
        log_debug "Applying overlay: ${overlay}"
        if [[ "$LOG_LEVEL" == "DEBUG" || "$LOG_LEVEL" == "INSANE" ]]; then
            ytt --ignore-unknown-comments \
                --output-files ${configPath} \
                -f ${configPath} \
                -f ${overlay}
        else
            ytt --ignore-unknown-comments \
                --output-files ${configPath} \
                -f ${configPath} \
                -f ${overlay} > /dev/null
        fi
    done <<< "${clusterOverlaysList}"
else
    log_info "No Cluster Overlay found!"
fi
fi

log_info "Done Applying Overlays!"
