#!/bin/bash
set -eou pipefail

apply_crds() {
    crdsPath=${1}
    # Create if not exists
    mkdir -p ${crdsPath}
    inputList=$(find ${crdsPath} -type f) || true
    
    log_info "Upgrading CRDs from: ${crdsPath}"

    if [[ "$filter" != "" ]] ; then
        inputList=$(echo "${inputList}" | grep ${filter}) || true
    fi

    log_insane "${inputList}"

    if [[ ! -z "${inputList}" ]] ; then
        echo "${inputList}" | grep -v .gitkeep | while read f; do
            # Replacing or creating CRDs
            log_debug "Upgrading: ${f}"
            log_debug "kubectl replace ${kubectlArgs} -R -f ${f} ${fluxManaged} || kubectl create ${kubectlArgs} -R -f ${f} ${fluxManaged}"
            result=$(kubectl replace ${kubectlArgs} -R -f ${f} ${fluxManaged} 2> /dev/null || kubectl create ${kubectlArgs} -R -f ${f} ${fluxManaged} 2> /dev/null) || true
            text=$(echo "${result}" | grep -E 'created|replaced' | awk '{split($0, a, "/"); print a[2]}') || true
            log_info "${text}"
        done || true
        log_info "Done Upgrading CRDs from: ${crdsPath}"
    else
        log_warn "No CRDs were found to update or create at: ${crdsPath}"
    fi

}

delete_crds() {
    crdsPath=${1}
    # Create if not exists
    mkdir -p ${crdsPath}
    inputList=$(find ${crdsPath} -type f) || true
    
    log_info "Deleting CRDs from: ${crdsPath}"

    if [[ "$filter" != "" ]] ; then
        inputList=$(echo "${inputList}" | grep ${filter}) || true
    fi

    log_insane "${inputList}"

    if [[ ! -z "${inputList}" ]] ; then
        echo "${inputList}" | grep -v .gitkeep | while read f; do
            # Replacing or creating CRDs
            log_debug "Deleting: ${f}"
            log_debug "kubectl delete ${kubectlArgs} -R -f ${f} ${fluxManaged}"
            result=$(kubectl delete ${kubectlArgs} -R -f ${f} ${fluxManaged} 2> /dev/null ) || true
            # text=$(echo "${result}" | grep -E 'created|replaced' | awk '{split($0, a, "/"); print a[2]}') || true
            # log_info "${text}"
        done || true
        log_info "Done Deleting CRDs from: ${crdsPath}"
    else
        log_warn "No CRDs were found to update or create at: ${crdsPath}"
    fi

}