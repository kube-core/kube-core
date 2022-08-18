#!/bin/bash
set -eou pipefail

# Old:
# find ${config_path} -type f -name "namespace.yaml" | xargs -i kubectl apply ${args} -f '{}'
# TODO: See how to improve the way namespaces are organised / handled / queried

apply_namespaces() {
    configPath=${1}
    mkdir -p ${configPath}
    inputList=$(find ${configPath}/namespace -type f) || true
    
    log_info "Applying config from: ${configPath}"

    if [[ "$filter" != "" ]] ; then
    inputList=$(echo "${inputList}" | grep ${filter}) || true
    fi

    log_insane "${inputList}"

    if [[ ! -z "${inputList}" ]] ; then
        echo "${inputList}" | grep -v .gitkeep | while read f; do
            # Applying Config
            log_debug "kubectl apply ${kubectlArgs} -R -f ${f} ${fluxManaged}"
            kubectl apply ${kubectlArgs} -R -f ${f} ${fluxManaged} || true
        done || true
        log_info "Done Applying config from: ${configPath}"
    else
        log_warn "No manifests were found to apply at: ${configPath}"
    fi

}

replace_namespaces() {
    configPath=${1}
    mkdir -p ${configPath}
    inputList=$(find ${configPath}/namespace -type f) || true
    
    log_info "Replacing config from: ${configPath}"

    if [[ "$filter" != "" ]] ; then
    inputList=$(echo "${inputList}" | grep ${filter}) || true
    fi

    log_insane "${inputList}"

    if [[ ! -z "${inputList}" ]] ; then
        echo "${inputList}" | grep -v .gitkeep | while read f; do
            # Replacing Config
            log_debug "kubectl replace ${kubectlArgs} -R -f ${f} ${fluxManaged}"
            kubectl replace ${kubectlArgs} -R -f ${f} ${fluxManaged} || true
        done || true
        log_info "Done Replacing config from: ${configPath}"
    else
        log_warn "No manifests were found to replace at: ${configPath}"
    fi

}

create_namespaces() {
    configPath=${1}
    mkdir -p ${configPath}
    inputList=$(find ${configPath}/namespace -type f) || true
    
    log_info "Creating config from: ${configPath}"

    if [[ "$filter" != "" ]] ; then
    inputList=$(echo "${inputList}" | grep ${filter}) || true
    fi

    log_insane "${inputList}"

    if [[ ! -z "${inputList}" ]] ; then
        echo "${inputList}" | grep -v .gitkeep | while read f; do
            # Creating Config
            log_debug "kubectl create ${kubectlArgs} -R -f ${f} ${fluxManaged}"
            kubectl create ${kubectlArgs} -R -f ${f} ${fluxManaged} || true
        done || true
        log_info "Done Creating config from: ${configPath}"
    else
        log_warn "No manifests were found to create at: ${configPath}"
    fi

}

delete_namespaces() {
    configPath=${1}
    mkdir -p ${configPath}
    inputList=$(find ${configPath}/namespace -type f) || true
    
    log_info "Deleting config from: ${configPath}"

    if [[ "$filter" != "" ]] ; then
    inputList=$(echo "${inputList}" | grep ${filter}) || true
    fi

    log_insane "${inputList}"

    if [[ ! -z "${inputList}" ]] ; then
        echo "${inputList}" | grep -v .gitkeep | while read f; do
            # Deleting Config
            log_debug "kubectl delete ${kubectlArgs} -R -f ${f} ${fluxManaged}"
            kubectl delete ${kubectlArgs} -R -f ${f} ${fluxManaged} || true
        done || true
        log_info "Done Deleting config from: ${configPath}"
    else
        log_warn "No manifests were found to delete at: ${configPath}"
    fi

}
