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
## Generates secrets for Tekton/Git features
## Docs End ##

# kubectl create secret generic

ssh_key=$(cat ${git_ssh_key} | base64 )
known_hosts=$(cat ${git_ssh_known_hosts} | base64 -w0 )
host=$(echo ${git_ssh_host})
token=$(cat ${git_webhooks_token} | base64 -w0 )
api_token=$(cat ${git_api_token} | base64 -w0 )
github_read_token=$(cat ${git_github_read_token} | base64 -w0 )

log_info "Generating git secrets..."

secret_ssh=$(kubectl create secret generic git-ssh --type kubernetes.io/ssh-auth --dry-run=client -o yaml --from-file=ssh-privatekey=${git_ssh_key} --from-file=known_hosts=${git_ssh_known_hosts} | yq '.metadata |= {"name": "git-ssh", "namespace": "secrets", "annotations" : {"replicator.v1.mittwald.de/replication-allowed": "true", "replicator.v1.mittwald.de/replication-allowed-namespaces": "*", "tekton.dev/git-1": "'"${host}"'"}}' -)


secret_token=$(cat <<EOF
apiVersion: v1
data:
  token: ${token}
kind: Secret
metadata:
  annotations:
    replicator.v1.mittwald.de/replication-allowed: "true"
    replicator.v1.mittwald.de/replication-allowed-namespaces: '*'
  name: git-webhooks-token
type: Opaque
EOF
)

secret_api_token=$(cat <<EOF
apiVersion: v1
data:
  token: ${api_token}
kind: Secret
metadata:
  annotations:
    replicator.v1.mittwald.de/replication-allowed: "true"
    replicator.v1.mittwald.de/replication-allowed-namespaces: '*'
  name: git-api-token
type: Opaque
EOF
)

secret_github_read_token=$(cat <<EOF
apiVersion: v1
data:
  token: ${github_read_token}
kind: Secret
metadata:
  annotations:
    replicator.v1.mittwald.de/replication-allowed: "true"
    replicator.v1.mittwald.de/replication-allowed-namespaces: '*'
  name: github-read-token
type: Opaque
EOF
)

mkdir -p ${secrets_path}/manifests/tekton-pipelines/
echo "${secret_ssh}" > ${secrets_path}/manifests/git-ssh.yaml
echo "${secret_ssh}" | sed 's/namespace: secrets/namespace: tekton-pipelines/' > ${secrets_path}/manifests/tekton-pipelines/git-ssh.yaml # ssh-auth can't be replicated :( TODO: Create issue on replicator
echo "${secret_token}" > ${secrets_path}/manifests/git-webhooks-token.yaml
echo "${secret_api_token}" > ${secrets_path}/manifests/git-api-token.yaml
echo "${secret_github_read_token}" > ${secrets_path}/manifests/github-read-token.yaml
