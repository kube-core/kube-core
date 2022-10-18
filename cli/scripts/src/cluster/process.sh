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
## Slices and post-processes all manifests.
## Docs End ##


log_info "Final Post-Processing..."

tmpConfigPath=${tmpFolder}/config
# configPath=${config_path}
configPath=${tmpConfigPath}
localPath=${localConfig_path}

slicingFolder=${tmpFolder}/releases/slicing
mkdir -p ${slicingFolder}
# rm -rf ${slicingFolder}

initialPath=$(pwd)

cd ${tmpConfigPath} &> /dev/null # Remove logs
manifestsList=$(find . -type f -name '*.yaml')

echo "${manifestsList}" | xargs yq '.' > ${tmpConfigPath}/config.all.yaml

# TODO: Find a way to choose easily how to slice
# {{(.metadata.labels | index "cluster.kube-core.io/context") |dottodash|replace ":" "-"}}/{{.metadata.namespace}}/{{(.metadata.labels | index "release.kube-core.io/name") |dottodash|replace ":" "-"}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'
if [[ "$LOG_LEVEL" == "DEBUG" || "$LOG_LEVEL" == "INSANE" ]] ; then
    kubectl slice -f ${tmpConfigPath}/config.all.yaml --output-dir ${config_path} --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'
else
    kubectl slice -f ${tmpConfigPath}/config.all.yaml --output-dir ${config_path} --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml' 2> /dev/null
fi
cd - &> /dev/null # Remove logs

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

# Generating namespaces (just before overlays so we can edit them)
# ${scripts_gitops_utils_generate_namespaces_path}

${scripts_gitops_overlay_path}

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
