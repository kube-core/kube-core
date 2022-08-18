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
corePath=$(echo ${scriptsConfigDirPath}/.. | xargs realpath)
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


log_info "Post-Processing GitOps config..."

tmpConfigPath=${tmpFolder}/config
inputConfigPath=${tmpConfigPath}

log_debug "Start Renaming: .yml => .yaml"
find ${inputConfigPath} -name '*.yml' -type f | while read f;
do
    newName=$(echo $f | sed 's/yml/yaml/')
    
    log_debug "Moving: ${f} => ${newName}"
    mv ${f} ${newName}
done || true
log_debug "Done Renaming: .yml => .yaml"


log_debug "Start Cleaning: files != .yaml"
find ${inputConfigPath} -type f | grep -vE '\.yaml' | while read f;
do
    log_debug "Deleting: ${f}"
    rm -rf ${f}
done || true
log_debug "Done Cleaning: files != .yaml"

# Copying CRDs
# TODO : Detect unwanted CRDs but do not include them. Treat them separately
# echo "Getting a local copy of all output CRDs..."
# mkdir -p ${crds_path}/imported
# crdsToCopy=$(grep -r -E -l 'kind: CustomResourceDefinition' ${inputConfigPath}) || true
# echo "${crdsToCopy}" | xargs -i cp -rf '{}' ${crds_path}/imported || true
# echo "Done getting a local copy of all output CRDs"

# Auto-seal secrets
# Gets all secrets not managed by replicator (grep could be improved to be more specific)
log_info "Checking for non-sealed secrets..."

secretsList=$(grep -r -l -E 'kind: Secret' ${inputConfigPath}) || true

if [[ ! -z "${secretsList}" ]]
then
    log_debug "Secrets found !"

    while read s
    do
        # Detecting specific secrets to exclude
        replicator=$(cat "${s}" | grep 'replicator')
        sa=$(cat "${s}" | grep 'type: kubernetes.io/service-account-token')
        hasData=$(cat "${s}" | yq e '. | has("data")' -)

        if [[ "${replicator}" ]]
        then
            log_debug "Skipping replicator managed secret: ${s}"
        elif [[ "${sa}" ]]
        then
            log_debug "Skipping service account token: ${s}"
        elif [[ "${hasData}" != "true" ]]
        then
            log_debug "Skipping empty secret: ${s}"
        else
            log_warn "Detected non-sealed secret: ${s}"
            log_warn "Please check the source of this secret!"
            log_warn "If this is not an auto-generated secret, consider provisionning yours instead!"
            log_warn "Auto-Sealing: ${s}"

            cat "${s}" | ${scripts_k8s_secrets_seal_path} > ${s}.sealed
            mv ${s}.sealed ${s}
        fi

    done <<< "${secretsList}" || true
else
    log_info "No non-sealed secrets found !"
fi
log_info "Done checking for non-sealed secrets!"


# Check untracked files in config
# TODO: Review and reimplement this, in final post-processing steps.
# Irrelevant here because now this is not in git context anymore (tmp folder update)

# # Getting a clean list of all files
# manifests=$(find ${inputConfigPath} -type f)

# # Exclude stuff
# # TODO: Find a way not to exclude tekton
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

log_info "Done Post-Processing GitOps config!"
