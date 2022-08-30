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



log_info "Final Post-Processing..."

tmpConfigPath=${tmpFolder}/config
# configPath=${config_path}
configPath=${tmpConfigPath}
localPath=${localConfig_path}

slicingFolder=${tmpFolder}/releases/slicing
mkdir -p ${slicingFolder}
# rm -rf ${slicingFolder}

initialPath=$(pwd)

# Slicing
# TODO: Make sure to implement filter at that level too, in order to improve performance
find ${configPath} -mindepth 1 -maxdepth 1 -type d | while read namespace; do

    namespaceName=$(echo ${namespace} | xargs basename)

    #  Generating manifests injected without a release
    # TODO: Fill issue about yq unable to merge many files with long path
    cd ${namespace} &> /dev/null # Remove logs
    manifestsList=$(find . -type f -name '*.yaml')

    # manifestsList=$(find . -type f -name '*.yaml' | grep -vE '^namespace\.yaml$') # TODO: Define if using this to simplify the tree for most releases
    log_insane "${manifestsList}"

    log_debug ${namespace}
    # echo ${namespace}
    # exit
    tmpNamespacePath="${namespace}/${namespaceName}.manifests.tmp.yaml"
    # outputNamespacePath="${slicingFolder}/${namespaceName}/manifests"
    outputNamespacePath="${slicingFolder}"
    mkdir -p ${outputNamespacePath}

    manifestsShortPath=$(echo "${tmpNamespacePath}" | sed "s|${configPath}|./config|")

    if [[ ! -z "${manifestsList}" ]] ; then

        log_info "Slicing: ./config/${namespaceName}/manifests"
        echo "${manifestsList}" | xargs yq '.' > ${tmpNamespacePath}

        log_debug "kubectl slice -f ${tmpNamespacePath} --output-dir ${outputNamespacePath} --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'"

        if [[ "$LOG_LEVEL" == "DEBUG" || "$LOG_LEVEL" == "INSANE" ]] ; then
            kubectl slice -f ${tmpNamespacePath} --output-dir ${outputNamespacePath} --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'
        else
            kubectl slice -f ${tmpNamespacePath} --output-dir ${outputNamespacePath} --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml' 2> /dev/null
        fi

        cd ${configPath}
        echo "${manifestsList}" | xargs rm -rf
        rm -rf ${tmpNamespacePath}
        # mv -f ${outputNamespacePath} ${outputNamespacePath}/${releaseName}
    fi
done

# Cluster Wide Manifests
mkdir -p ${configPath}/cluster-wide-manifests
cd ${configPath} &> /dev/null # Remove logs
clusterWideManifests=$(find . -mindepth 1 -maxdepth 1 -type f -name '*.yaml') || true
if [[ ! -z "${clusterWideManifests}" ]] ; then

    echo "${clusterWideManifests}" | xargs yq '.' > ${slicingFolder}/cluster-wide-manifests.yaml
    if [[ "$LOG_LEVEL" == "DEBUG" || "$LOG_LEVEL" == "INSANE" ]] ; then
        kubectl slice -f ${slicingFolder}/cluster-wide-manifests.yaml --output-dir ${slicingFolder}/cluster-wide-resources --template='{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'
    else
        kubectl slice -f ${slicingFolder}/cluster-wide-manifests.yaml --output-dir ${slicingFolder}/cluster-wide-resources --template='{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml' 2> /dev/null
    fi
    rm -rf ${slicingFolder}/cluster-wide-manifests.yaml
fi


cd ${initialPath} &> /dev/null # Remove logs

# rm -rf ${configPath} # Old way
rm -rf ${configPath}-before-slice
mkdir -p ${configPath}-before-slice # Resets config cache

cp -rf ${configPath}/* ${configPath}-before-slice # Keep track of files to debug easily if needed
rm -rf ${configPath} # Removes everything

mkdir -p ${configPath}
cp -rf ${slicingFolder}/* ${configPath}

# If filter, only copy what matches filter
if [[ "$filter" != "" ]] ; then
    # TODO: Experimental. Test well and improve if possible.
    # Doesn't work well because it makes files go up. Need to extract folders with files that match the pattern
    # log_debug "cp -rf ${configPath}/*${filter}* ${configPath}/*/*${filter}* ${config_path}"
    # cp -rf ${configPath}/*${filter}* ${configPath}/*/*${filter}* ${config_path}

    configFolders=$(find ${configPath} -type d -mindepth 1 -maxdepth 1)

    if [[ "${configFolders}" != "" ]]; then
        rm -rf "${clusterConfigDirPath}/.kube-core/.reportProcessFilesCopied"

        echo "${configFolders}" | while read directory; do
            log_debug "${directory}"

            filesMatchFilter="false"
            filesMatchingFilter=$(find ${directory} -type f -name '*.yaml' | grep ${filter}) || true
            log_debug "${filesMatchingFilter}"
            if [[ ! -z "${filesMatchingFilter}" ]]; then
                filesMatchFilter="true"

                log_debug "Files matched in ${directory}: ${filesMatchFilter}"

                echo "${filesMatchingFilter}" | while read currentFile; do
                    destinationFile=$( echo "${currentFile}" | sed "s|$configPath||")
                    log_debug "${currentFile} -> ${destinationFile}"

                    if [[ ! -z "${currentFile}" ]]; then

                        destinationDir=$(echo "${destinationFile}" | xargs dirname)
                        destinationFileName=$(echo "${destinationFile}" | xargs basename)

                        log_debug "Copying: ${destinationFile}"
                        echo "${destinationFile}" >> ${clusterConfigDirPath}/.kube-core/.reportProcessFilesCopied

                        mkdir -p ${config_path}/${destinationDir}
                        cp -rf "${currentFile}" ${config_path}/${destinationDir}/${destinationFileName}
                    fi
                done
            else
                destinationDir=$(echo "${directory}" | sed "s|$configPath||")
                log_debug "No files matched in ${destinationDir}"
            fi

        done
    else
        log_warn "No folders found in config!"
    fi
# Or copy everything
else
    log_debug "Copying everything..."
    cp -rf ${configPath}/* ${config_path}
fi

if [[ "$filter" != "" ]]; then
    if [[ -f "${clusterConfigDirPath}/.kube-core/.reportProcessFilesCopied" ]]; then
        debugOutput=$(cat "${clusterConfigDirPath}/.kube-core/.reportProcessFilesCopied")
        log_debug "${debugOutput}"
    else
        log_warn "No files copied! Maybe --filter is too restrictive?"
    fi
fi


log_info "Deleting empty files..."
emptyFiles=$(find ${config_path} -name ".yaml")

if [[ "${emptyFiles}" != "" ]]; then
    log_debug "Empty files found, deleting them! You probably need to check the templating using debug mode."
    log_insane "${emptyFiles}"
    echo "${emptyFiles}" | xargs rm -rf
fi

# Cleaning cache
log_info "Cleaning cache..."
rm -rf ${clusterConfigDirPath}/.kube-core



log_info "Done Final Post-Processing..."




# Disabled for now
# TODO: Decide if this is still relevant.

# helmfileArgs=${@:-""}

# log_debug "Post-processing helmfile output..."

# utf8Files=$(file -i -f ${clusterConfigDirPath}/helmfile-config.lock | grep utf-8 | awk '{print $1}' | sed 's/://') || true

# if [[ ! -z ${utf8Files} ]]; then

# echo "${utf8Files}" | while read f; do
#     log_debug "Encoding ${f} from utf-8 to ascii"
#     # TODO: Check if we can use an alternative of the following on Alpine Linux

#     osType=$(cat /etc/os-release | grep -E '^ID=' | awk '{split($0, a, "="); print a[2]}') || true

#     if [[ "${osType}" == "alpine" ]]; then
#         cat ${f} | iconv -f utf-8 -t ascii > ${f}.edited
#     else
#         cat ${f} | iconv -f utf-8 -t ascii//TRANSLIT > ${f}.edited
#     fi
#     mv ${f}.edited ${f}
# done
# else
#     log_debug "Nothing to encode from utf-8 to ascii"
# fi

# log_debug "Done post-processing helmfile output!"



# Check untracked files in config
# TODO: Review and reimplement this, in final post-processing steps.
# Irrelevant here because now this is not in git context anymore (tmp folder update)

# # # Getting a clean list of all files
# manifests=$(find ${inputConfigPath} -type f)

# # # Exclude stuff
# # # TODO: Find a way not to exclude tekton
# excludedManifests=$(echo "$manifests" | grep tekton || true)
# manifests=$(echo "$manifests" | grep -v tekton || true)

# cd ${clusterConfigDirPath}
# untrackedFiles=$(git ls-files ${inputConfigPath} --exclude-standard --others)
# cd - &> /dev/null # Remove logs

# if [[ "${run_kbld}" == "true" ]]
# then

#     kbldLock=${clusterConfigDirPath}/kbld.lock.yaml

#     rm -rf ${kbldLock}
#     # TODO: Better condition handling and reactivate this
#     # If new files were added to config, delete old lockfile
#     # if [[ ! -z "${untrackedFiles}" ]]
#     # then
#     #     echo "New deployments detected, deleting kbld.lock..."
#     #     rm -rf ${kbldLock}
#     # else
#     #     echo "No new deployments detected, skipping kbld"
#     # fi

#     # If lockfile doesn't exist, generate it
#     if [[ ! -s "${kbldLock}" ]]
#     then
#         log_debug "No kbld.lock, preparing to generate it..."


#         # Temporarily move excluded manifests
#         mkdir -p ${clusterConfigDirPath}/.tmp
#         log_debug "Moving temporarily excluded files..."
#         mv ${inputConfigPath}/tekton-pipelines ${clusterConfigDirPath}/.tmp  2>/dev/null || true

#         # Check & Generate lockfile


#         # echo "Filtering manifests to send to kbld..."
#         # kbldArgs=$(echo "${manifests}" | xargs -i echo "-f {}")

#         log_debug "Analyzing manifests..."
#         kbld -f ${inputConfigPath} --registry-insecure --registry-verify-certs=false --lock-output ${kbldLock} > /dev/null
#         log_debug "Lockfile Generated !"

#         # Replace images
#         echo "Start kbld"
#         echo "${manifests}" | while read f;
#         do
#             log_debug "kbld: ${f}"
#             log_debug "kbld -f ${kbldLock} -f ${f} --registry-insecure --registry-verify-certs=false > ${f}.kbld"
#             kbld -f ${kbldLock} -f ${f} --registry-insecure --registry-verify-certs=false > ${f}.kbld
#             mv ${f}.kbld ${f}
#         done || true
#         echo "Done kbld"


#         # Moving back excluded manifests
#         log_debug "Moving back excluded files..."
#         cp -r ${clusterConfigDirPath}/.tmp/tekton-pipelines ${inputConfigPath} || true

#         # Cleaning
#         log_debug "Cleaning up..."
#         rm -rf ${clusterConfigDirPath}/.tmp

#     fi

# fi
