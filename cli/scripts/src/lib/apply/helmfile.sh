#!/bin/bash
## Docs Start ##
## A lib of utils to wrap helmfile
## Docs End ##
set -eou pipefail

helmfile_apply() {
    helmfileCommand=$(helmfile_apply_command)
    if [[ "$kubectlArgs" == *"--dry-run"* ]] ; then
        echo "[dry-run] ${helmfileCommand}"
    else
        ${helmfileCommand} || true
    fi
}

helmfile_repos() {
    helmfile -f ${helmfilePath} repos || true
}

helmfile_apply_command() {

    helmfileAction="apply"
    helmfileActionArgs=${1:-"--skip-deps"}

    helmfileCommand=$(helmfile_build_command ${helmfileAction} ${helmfileActionArgs})
    echo "${helmfileCommand}"
}

helmfile_list() {

    helmfileAction="list"
    helmfileActionArgs=${1:-""}

    helmfileCommand=$(helmfile_build_command ${helmfileAction} ${helmfileActionArgs})
    ${helmfileCommand} || true
}

helmfile_template_command() {

    helmfileAction="template"
    helmfileActionArgs=${1:-"--skip-deps --include-transitive-needs"}

    helmfileCommand=$(helmfile_build_command ${helmfileAction} ${helmfileActionArgs})

    echo "${helmfileCommand}"
}

helmfile_template() {
    helmfileCommand=$(helmfile_template_command)
    ${helmfileCommand} || true
}

helmfile_add_namespaces_to_manifests() {
    release=${1}
    templatesOutputDir=${2}
    name=$(echo ${release} | awk '{print $1}')
    namespace=$(echo ${release} | awk '{print $2}')
    enabled=$(echo ${release} | awk '{print $3}')
    installed=$(echo ${release} | awk '{print $4}')
    releasePath="${templatesOutputDir}/${namespace}/${name}"
    file="${releasePath}/all.yaml"

    if [[ "$enabled" == "true" && "$installed" == "true" && -f "${file}" ]] ; then
        mkdir -p ${releasePath}
        # Adding namespace to manifests
        log_debug "Adding namespace ${namespace} to manifest: ${file}"
        namespace="${namespace}" yq e '.metadata.namespace = env(namespace)' -i ${file}
    fi
}

helmfile_template_release() {
    release=${1}
    templatesOutputDir=${2}
    name=$(echo ${release} | awk '{print $1}')
    namespace=$(echo ${release} | awk '{print $2}')
    enabled=$(echo ${release} | awk '{print $3}')
    installed=$(echo ${release} | awk '{print $4}')
    releasePath="${templatesOutputDir}/${namespace}/${name}"

    if [[ "$enabled" == "true" && "$installed" == "true" ]] ; then
        mkdir -p ${releasePath}

        log_info "Templating: ${cluster_config_name}/${namespace}/${name}"

        # Overriding helmfileSelectorOverride argument from helmfile_build_command :)
        helmfileCommand=$(helmfileSelectorOverride="-l name=${name},namespace=${namespace}" helmfile_template_command)

        log_debug "${helmfileCommand} > ${releasePath}/all.yaml"

        if [[ "$LOG_LEVEL" == "DEBUG" || "$LOG_LEVEL" == "INSANE" ]] ; then
            ${helmfileCommand} > ${releasePath}/all.yaml
        else
            ${helmfileCommand} > ${releasePath}/all.yaml 2> /dev/null
        fi

        log_debug "Wrote ${namespace}/${name}/all.yaml"
    fi
}

helmfile_build_command() {
    helmfileSelectorExpression=""

    # TODO: Put everything here in a function in the lib (apply_helmfiles). Feed all the paths and process them.
    # TODO: Improve filtering.
    if [[ "${filter}" != "" ]] ; then
        helmfileSelectorExpression=" -l name=${filter} -l namespace=${filter}"
    fi

    # Quick Helmfile Selector.
    # Examples:
    # key=value
    # key=value,key2=value2
    if [[ "$helmfileSelector" != "" ]] ; then
        helmfileSelectorExpression="${helmfileSelectorExpression} -l ${helmfileSelector}"
    fi

    # Full Helmfile Selector.
    # Examples:
    # -l key=value
    # -l key=value,key2=value2 -l key3=value3 -l key4!=value4,key5=value5
    if [[ "$helmfileSelectorOverride" != "" ]] ; then
        helmfileSelectorExpression=" ${helmfileSelectorOverride}"
    fi


    helmfileCommand="helmfile ${helmfileSelectorExpression} -f ${helmfilePath} ${helmfileAction} ${helmfileActionArgs}"

    echo ${helmfileCommand}
}
