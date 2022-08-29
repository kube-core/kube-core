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


log_info "Restoring secrets..."


# If any secrets were not regenerated, restore them
# TODO: Better detection of secrets (see below, maybe based on grep too)
cd ${config_path}
secretsToRestore=$(git ls-files -d | grep -E '/secrets/|/sealedsecret/|/secret/') || true

if [ ! -z "${secretsToRestore}" ]
then
    log_debug "Restoring deleted secrets..."
    echo "${secretsToRestore}" | xargs git restore -- || true

    log_debug "Restored secrets:"
    log_debug "${secretsToRestore}"
fi

# Restore modified secrets to not ruin git history
# if [[ "${arg1}" == "secrets" || "${arg2}" == "secrets" || "${arg3}" == "secrets" ]]
# then
#     echo "Skip restoring modified secrets"
# else
    log_info "Checking for modified/deleted secrets to restore..."
    log_debug "This should only target modified secrets that didn't change (except hashing by SealedSecrets)"
    
    modifiedFiles=$(git ls-files -m) || true
    
    log_insane "List of modified files :"
    log_insane "${modifiedFiles}"

    if [[ ! -z "${modifiedFiles}" ]]
    then
        while read s
        do
            # cat "${s}" | grep -E 'kind: SealedSecret'
            # secretsList=$(grep -r -l -E 'kind: Secret' ${config_path}) || true

            if [[ -f "${s}" ]]
            then
                if [[ "$(cat "${s}" | grep -E 'kind: SealedSecret')" ]]
                then
                    log_info "Restoring SealedSecret: ${s}"
                    git restore ${s}
                else
                    log_debug "Ignoring: ${s}"
                fi
            fi

        done <<< "${modifiedFiles}" || true
    fi # end if [[ ! -z "${modifiedFiles}" ]]

# fi

cd - &> /dev/null # Remove logs

log_debug "Done checking for secrets to restore"

log_info "Done Restoring secrets..."
