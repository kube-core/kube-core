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


ENV=${ENV:-"local"}

sourceBranch=${1:-"develop"}
targetBranch=${2:-"${sourceBranch}"}
workBranch=${3:-"gitops/update-${sourceBranch}"}


configureGit="false"
installRequirements="false"
runBuild="false"

if [[ "${ENV}" == "ci" ]]; then
    configureGit="true"
    installRequirements="false"
    runBuild="false"
fi

clusterPath="${clusterConfigDirPath}"

somethingChanged="false"

# Setting up Git
if [[ "${configureGit}" == "true" ]]; then
    git config --global user.email "${git_bot_user}"
        git config --global user.name "${git_bot_name}"
fi

# Checking out the branch
cd ${clusterConfigDirPath}

log_info "Source branch: ${sourceBranch}"
log_info "Target branch: ${targetBranch}"
log_info "Work branch: ${workBranch}"

log_info "Checking out the target branch: ${targetBranch}"
git checkout ${targetBranch} || true

log_info "Fetching and pulling target branch: ${targetBranch}"
git fetch -a || true
git pull origin ${targetBranch} || true

# log "Checking out ${workBranch}"
# git checkout -b ${workBranch} || true
# git pull origin ${workBranch} || true

# log "Rebasing ${workBranch} on ${targetBranch}"
# git rebase ${targetBranch}

# log "Merging ${sourceBranch} on ${workBranch}"
# git merge ${sourceBranch}

# log "Pushing changes & Creating PR..."
# git push --set-upstream origin ${workBranch} -o merge_request.create -o merge_request.target=${targetBranch}

log_info "Checking if work branch already exists: origin/${workBranch}"
if git rev-parse --quiet --verify origin/${workBranch}; then
    log_warn "Branch already exists"
    log_warn "Deleting branch and rebuilding !"
    log_warn "This part should be updated to handle rebase instead of delete/recreate !"

    log_info "Deleting ${workBranch}"
    git push origin :${workBranch}

    # log_info "Checking out ${workBranch}"
    # git checkout --track origin/${workBranch} || true

    # log_info "Rebasing ${workBranch} on ${targetBranch}"
    # git rebase ${targetBranch}

    # log_info "Merging ${sourceBranch} on ${workBranch}"
    # git merge ${sourceBranch}
fi


    log_info "Creating work branch: ${workBranch}"

    log_info "Checking out ${workBranch}"
    git checkout -b ${workBranch} || true

    log_info "Pushing and setting upstream: ${workBranch}"
    git push -u origin ${workBranch} || true
    # git branch --set-upstream-to=origin/${workBranch} ${workBranch} || true
    # git pull origin ${workBranch} || true

cd -

# Installing requirements
# TODO: Put in devops-tools docker image
if [[ "${installRequirements}" == "true" ]]; then
    ${scripts_gitops_utils_install_requirements_path}
fi

# Building
if [[ "${runBuild}" == "true" ]]; then
    ${scripts_build_path}
fi
