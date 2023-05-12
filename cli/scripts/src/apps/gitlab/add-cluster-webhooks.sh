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
## Adds tekton webhooks to all applications in a GiLab group
## Docs End ##

if ! which gitlab >/dev/null; then
    echo "gitlab is not installed, please install it"
    exit 2
fi

project_id=$1
url=${2:-"https://cluster-hooks.tekton-pipelines.$cluster_config_domain"}
token=$(cat ${git_webhooks_token})

projects=$(gitlab -o json -f id,name project get --id $project_id 2> /dev/null | jq -c)
project_name=
hook_id=

check_hook() {
    hooks=$(gitlab -o json -f id,url project-hook list --project-id $project_id 2> /dev/null)
    while IFS= read -r hook; do
        hook_base_url=$(echo $hook | jq -r ".url" | awk -F'?' '{ print $1  }' | sed 's/"//')
        hook_id=$(echo $hook | jq ".id")
        base_url=$(echo $url | awk -F'?' '{ print $1  }')
        if [[ $hook_base_url == $base_url ]]; then
            update_hook
        else
            create_hook
        fi
    done <<<  "$(echo $hooks | jq -c ".[]")"
}

create_hook() {
    echo "Add hook $url to $project_name"
    gitlab project-hook create --project-id $project_id --url $url --push-events true --tag-push-events true --merge-requests-events false --enable-ssl-verification true --token $token 2> /dev/null
}


update_hook() {
    echo "Updating hook on $project_name to $url"
    gitlab project-hook update --project-id $project_id --id $hook_id --url $url --token $token 2> /dev/null
}

while IFS= read -r line; do
    project_id=$(echo $line | jq ".id")
    project_name=$(echo $line | jq ".name")
    check_hook
done <<< "$(echo $projects)"
