#!/bin/bash
## Docs Start ##
## A lib of utils to wrap kubectl
## Docs End ##
set -eou pipefail

kubectl_slice_helmfile_templated_release() {
    release=${1}
    templatesOutputDir=${2}
    name=$(echo ${release} | awk '{print $1}')
    namespace=$(echo ${release} | awk '{print $2}')
    enabled=$(echo ${release} | awk '{print $3}')
    installed=$(echo ${release} | awk '{print $4}')
    releasePath="${templatesOutputDir}/${namespace}/${name}"

    log_debug ${releasePath}
    tmpReleasePath="${releasePath}.release.tmp.yaml"
    slicingFolder=${tmpFolder}/releases/slicing
    outputReleasePath="${slicingFolder}"
    mkdir -p ${outputReleasePath}


    # TODO: Fill issue about yq unable to merge many files with long path
    cd ${releasePath} &> /dev/null # Remove logs
    releaseFilesList=$(find . -type f -name '*.yaml')
    log_insane "${releaseFilesList}"
    releaseShortPath=$(echo "${tmpReleasePath}" | sed "s|${config_path}|./config|")

    # echo ${release}

    if [[ ! -z "${releaseFilesList}" ]] ; then
        echo "${releaseFilesList}" | xargs yq '.' > ${tmpReleasePath}

        # echo "${releaseFilesList}"

        log_debug "Slicing: ${cluster_config_name}/${namespace}/${name}"
        log_debug "kubectl slice -f ${tmpReleasePath} --output-dir ${outputReleasePath} --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'"

        if [[ "$LOG_LEVEL" == "DEBUG" || "$LOG_LEVEL" == "INSANE" ]] ; then
            kubectl slice -f ${tmpReleasePath} --output-dir ${outputReleasePath} --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'
        else
            kubectl slice -f ${tmpReleasePath} --output-dir ${outputReleasePath} --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml' 2> /dev/null
        fi

        cd ${configPath}
        rm -rf ${releasePath} ${tmpReleasePath}
        # mv -f ${outputReleasePath} ${namespace}/${release}
    fi

}

kubectl_slice_helmfile_templated_all() {
    templatesOutputDir=${1}
    releasePath="${templatesOutputDir}/${cluster_config_name}"

    log_debug ${releasePath}
    tmpReleasePath="${releasePath}.release.tmp.yaml"
    slicingFolder=${tmpFolder}/releases/slicing
    outputReleasePath="${slicingFolder}"
    mkdir -p ${outputReleasePath}


    # TODO: Fill issue about yq unable to merge many files with long path
    cd ${releasePath} &> /dev/null # Remove logs
    releaseFilesList=$(find . -type f -name '*.yaml')
    log_insane "${releaseFilesList}"
    releaseShortPath=$(echo "${tmpReleasePath}" | sed "s|${config_path}|./config|")

    # echo ${release}

    if [[ ! -z "${releaseFilesList}" ]] ; then
        echo "${releaseFilesList}" | xargs yq '.' > ${tmpReleasePath}

        # echo "${releaseFilesList}"

        log_debug "Slicing: ${cluster_config_name}"
        log_debug "kubectl slice -f ${tmpReleasePath} --output-dir ${outputReleasePath} --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'"

        if [[ "$LOG_LEVEL" == "DEBUG" || "$LOG_LEVEL" == "INSANE" ]] ; then
            kubectl slice -f ${tmpReleasePath} --output-dir ${outputReleasePath} --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'
        else
            kubectl slice -f ${tmpReleasePath} --output-dir ${outputReleasePath} --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml' 2> /dev/null
        fi

        cd ${configPath}
        rm -rf ${releasePath} ${tmpReleasePath}
        # mv -f ${outputReleasePath} ${namespace}/${release}
    fi

}
