#!/bin/bash
set -eou pipefail

LOG_LEVEL=${LOG_LEVEL:-"INFO"}
LOG_SHOW_CURRENT_SCRIPT=${LOG_SHOW_CURRENT_SCRIPT:-"false"}

log() {
    log_info "$@"
}

log_insane() {
    log_header=""
    if [[ "$LOG_SHOW_CURRENT_SCRIPT" == "true" ]]; then
        log_header=$(echo "${currentScriptShortPath}")
    fi

    if [[ "$LOG_LEVEL" == "INSANE" ]]; then
        if [[ ! -z ${cluster_config_name+x} ]] ; then
            echo "${log_header}:INSANE: ${cluster_config_name} - $1"
        else
            echo "${log_header}:INSANE: kube-core - $1"
        fi
    fi
}

log_debug() {
    log_header=""
    if [[ "$LOG_SHOW_CURRENT_SCRIPT" == "true" ]]; then
        log_header=$(echo "${currentScriptShortPath}")
    fi

    if [[ "$LOG_LEVEL" == "DEBUG" || "$LOG_LEVEL" == "INSANE"  ]]; then
        if [[ ! -z ${cluster_config_name+x} ]] ; then
            echo "${log_header}:DEBUG: ${cluster_config_name} - $1"
        else
            echo "${log_header}:DEBUG: kube-core - $1"
        fi
    fi
}

log_info() {
    log_header=""
    if [[ "$LOG_SHOW_CURRENT_SCRIPT" == "true" ]]; then
        log_header=$(echo "${currentScriptShortPath}")
    fi

    if [[ "$LOG_LEVEL" == "INFO" || "$LOG_LEVEL" == "DEBUG" || "$LOG_LEVEL" == "INSANE"  ]]; then
        if [[ ! -z ${cluster_config_name+x} ]] ; then
            echo "${log_header}:INFO: ${cluster_config_name} - $1"
        else
            echo "${log_header}:INFO: kube-core - $1"
        fi
    fi
}

log_warn() {
    log_header=""
    if [[ "$LOG_SHOW_CURRENT_SCRIPT" == "true" ]]; then
        log_header=$(echo "${currentScriptShortPath}")
    fi

    if [[ "$LOG_LEVEL" == "WARNING" || "$LOG_LEVEL" == "INFO" || "$LOG_LEVEL" == "DEBUG" || "$LOG_LEVEL" == "INSANE"  ]]; then
        if [[ ! -z ${cluster_config_name+x} ]] ; then
            echo "${log_header}:WARNING: ${cluster_config_name} - $1"
        else
            echo "${log_header}:WARNING: kube-core - $1"
        fi
    fi
}

log_error() {
    log_header=""
    if [[ "$LOG_SHOW_CURRENT_SCRIPT" == "true" ]]; then
        log_header=$(echo "${currentScriptShortPath}")
    fi

    if [[ "$LOG_LEVEL" == "ERROR" || "$LOG_LEVEL" == "WARNING" || "$LOG_LEVEL" == "INFO" || "$LOG_LEVEL" == "DEBUG" || "$LOG_LEVEL" == "INSANE"  ]]; then
        if [[ ! -z ${cluster_config_name+x} ]] ; then
            echo "${log_header}:ERROR: ${cluster_config_name} - $1"
        else
            echo "${log_header}:ERROR: kube-core - $1"
        fi
    fi
}