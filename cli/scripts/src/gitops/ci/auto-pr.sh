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


sourceBranch=${1:-"develop"}
targetBranch=${2:-"${sourceBranch}"}
workBranch=${3:-"gitops/update-${sourceBranch}"}
commitMessage=${4:-"gitops: Regen (auto)"}

# Checking out the branch
cd ${clusterConfigDirPath}


log_info "Checking if work branch already exists: origin/${workBranch}"
if git rev-parse --quiet --verify origin/${workBranch}; then
    if [[ "${workBranch}" == "gitops/update-${targetBranch}" ]]; then
        # log_error "Branch already exists, this case is not handled. Aborting!"
        # exit 1

        log_warn "Deleting branch and rebuilding !"
        log_warn "This part should be updated to handle rebase instead of delete/recreate !"

        log_info "Deleting ${workBranch}"
        git push origin :${workBranch}

    fi
fi

if [[ "${workBranch}" == "gitops/update-${targetBranch}" || "${workBranch}" == "core/update-${sourceBranch}" ]]; then
    log_info "Creating work branch: ${workBranch}"

    log_info "Checking out ${workBranch}"
    git checkout -b ${workBranch} || true

fi

cd -

somethingChanged="false"


cd ${clusterConfigDirPath}
if [[ "${GIT_ADD_ALL_FILES}" == "true" ]]; then
    gitStatus=$(git status --porcelain .)
else
    gitStatus=$(git status --porcelain ${config_path})
fi
if [[ ! -z "${gitStatus}" ]]; then
  somethingChanged="true"
fi
cd -

if [[ "${somethingChanged}" == "true" ]]; then
    cd ${clusterConfigDirPath}

    log "Changes detected in config !"
    echo "${gitStatus}"

    log "Adding config files..."
    if [[ "${GIT_ADD_ALL_FILES}" == "true" ]]; then
        git add .
    else
        git add ${config_path}
    fi

    log "Committing..."
    git commit -m "${commitMessage}"

    log "Pushing changes & Updating PR..."
    git pull origin ${workBranch} || true

    gitPushOpts="-o merge_request.create -o merge_request.target=${targetBranch} -o merge_request.remove_source_branch"
    if [[ "PR_AUTO_MERGE" == "true" ]]; then
        gitPushOpts="${gitPushOpts} -o merge_request.merge_when_pipeline_succeeds"
    fi
    git push --set-upstream origin ${workBranch} ${gitPushOpts}
    #-o merge_request.title="" -o merge_request.description="<description>"

    cd -
else
    log "No changes detected in config !"
    if [[ -z "${APPLY}" ]]; then
        APPLY=""
    fi

    if [[ -z "${APPLY_DRY_RUN}" ]]; then
        APPLY_DRY_RUN=""
    fi

    if [[ "${APPLY}" == "true" ]]; then
        if [[ "${workBranch}" == "${gitops_ref}" ]]; then
            log_info "Applying..."
            kube-core apply all --dry-run=${APPLY_DRY_RUN}
        else
            log_info "Apply is enabled but requires work branch to be: ${gitops_ref}"
        fi

        if [[ "${APPLY_DRY_RUN}" == "client" || "${APPLY_DRY_RUN}" == "server" ]]; then
            if [[ "${workBranch}" == "${gitops_ref}" ]]; then
                log_info "Applying..."
                kube-core apply all --dry-run=${APPLY_DRY_RUN}
            else
                log_info "Apply is enabled but requires work branch to be: ${gitops_ref}"
            fi
        fi
    fi

fi
