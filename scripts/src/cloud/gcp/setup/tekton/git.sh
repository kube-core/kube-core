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


# kubectl create secret generic

ssh_key=$(cat ${git_ssh_key} | base64 -w0 )
known_hosts=$(cat ${git_ssh_known_hosts} | base64 -w0 )
host=$(echo ${git_ssh_host})
token=$(echo ${git_webhooks_token} | base64 -w0 )
api_token=$(echo ${git_api_token} | base64 -w0 )

echo "Generating git secrets..."

secret_ssh=$(cat <<EOF
apiVersion: v1
data:
  known_hosts: ${known_hosts}
  ssh-privatekey: ${ssh_key}
kind: Secret
metadata:
  annotations:
    tekton.dev/git-1: ${host}
  name: ${git_provider}-ssh
  namespace: tekton-pipelines
type: kubernetes.io/ssh-auth
EOF
)

secret_token=$(cat <<EOF
apiVersion: v1
data:
  token: ${token}
kind: Secret
metadata:
  name: ${git_provider}-token
  namespace: tekton-pipelines
type: Opaque
EOF
)

secret_api_token=$(cat <<EOF
apiVersion: v1
data:
  token: ${api_token}
kind: Secret
metadata:
  name: ${git_provider}-token
  namespace: tekton-pipelines
type: Opaque
EOF
)

mkdir -p ${secrets_path}/manifests/tekton-pipelines

echo "${secret_ssh}" > ${secrets_path}/manifests/tekton-pipelines/${git_provider}-ssh.yaml
echo "${secret_token}" > ${secrets_path}/manifests/tekton-pipelines/${git_provider}-token.yaml
echo "${secret_token}" > ${secrets_path}/manifests/tekton-pipelines/${git_provider}-api-token.yaml