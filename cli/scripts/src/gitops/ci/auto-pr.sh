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
## Used in CI. Creates a PR/push for the current branch and changeset. Applies if enabled.
## Docs End ##


sourceBranch=${1:-"develop"}
targetBranch=${2:-"${sourceBranch}"}
workBranch=${3:-"gitops/update-${sourceBranch}"}
commitMessage=${4:-"gitops: Regen (auto)"}

# Checking out the branch
cd ${clusterConfigDirPath}

branchExisted="false"
branchDeleted="false"
log_info "Checking if work branch already exists: origin/${workBranch}"
if git rev-parse --quiet --verify origin/${workBranch}; then
    branchExisted="true"
    log_info "Work branch already exists: origin/${workBranch}"
    if [[ "${workBranch}" == "gitops/update-${targetBranch}" || "${workBranch}" == "core/update-${sourceBranch}" ]]; then

        log_warn "Deleting branch and rebuilding ! (outdated auto-generated update branch)"
        log_warn "This part should be updated to handle rebase instead of delete/recreate !"

        log_info "Deleting ${workBranch}"
        git push origin :${workBranch}
        branchDeleted="true"
    fi
else
    log_info "Work branch does not exists: origin/${workBranch}"
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
    log_info "Checking all files"
    gitStatus=$(git status --porcelain .)
else
    log_info "Checking only config"
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

    log "Adding files to git..."
    if [[ "${GIT_ADD_ALL_FILES}" == "true" ]]; then
        log_info "Adding all files"
        git add .
    else
        log_info "Adding only config"
        git add ${config_path}
    fi

    log "Committing..."
    git commit -m "${commitMessage}"

    log "Pushing changes & Updating PR..."
    git pull origin ${workBranch} || true

    if [[ "${branchExisted}" == "false" || "${branchDeleted}" == "true" ]]; then
        gitPushOpts="-o merge_request.create -o merge_request.target=${targetBranch} -o merge_request.remove_source_branch"
        if [[ "${PR_AUTO_MERGE}" == "true" ]]; then
            log_info "Merging when pipeline will succeed!"
            gitPushOpts="${gitPushOpts} -o merge_request.merge_when_pipeline_succeeds"
        fi
    else
        gitPushOpts=""
    fi


    log_info "Push command: git push --set-upstream origin ${workBranch} ${gitPushOpts}"
    git push --set-upstream origin ${workBranch} ${gitPushOpts}

    cd -
else
    log "No changes detected in config !"
    if [[ -z "${APPLY}" ]]; then
        APPLY=""
    fi

    if [[ -z "${APPLY_DRY_RUN}" ]]; then
        APPLY_DRY_RUN=""
    fi

    # TODO: Make this an independent script and step in CI instead. Integrate better kube-core tasks with CLI arguments.
    if [[ "${APPLY}" == "true" ]]; then
        log_info "Updating Helm repos..."
        if [[ "${APPLY_DRY_RUN}" == "client" || "${APPLY_DRY_RUN}" == "server" ]]; then
            if [[ "${workBranch}" == "gitops/update-${gitops_ref}" && "${sourceBranch}" == "${gitops_ref}" && "${targetBranch}" == "${gitops_ref}" ]]; then
                helmfile repos
                log_info "Applying..."
                kube-core apply all --dry-run=${APPLY_DRY_RUN}
            else
                log_info "Apply is enabled but source and target branch to be: ${gitops_ref}"
            fi
        else
            if [[ "${workBranch}" == "gitops/update-${gitops_ref}" && "${sourceBranch}" == "${gitops_ref}" && "${targetBranch}" == "${gitops_ref}" ]]; then
                helmfile repos
                log_info "Applying... (dry-run)"
                kube-core apply all --dry-run=${APPLY_DRY_RUN}
            else
                log_info "Apply is enabled but source and target branch to be: ${gitops_ref}"
            fi
        fi
    fi

fi
