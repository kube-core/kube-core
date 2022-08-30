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


# TODO: Decide what to do with this
log_debug "${project_name} - Gitops Replicated Secrets"

configPath=${config_path}
localConfigPath=${localConfig_path}
buildPath=${build_path}

secretsPath=${secrets_path}/output
replicatedSecretsPath=${secrets_path}/replicated


echo "Generating replicated secrets..."

echo "Generating replicated secrets for: tekton-pipelines"
if [[ "${install_tekton}" == "true" && "${install_gcr}" == "true" && "${cloud_provider}" == "gcp" ]]; then

secret_gcr=$(cat <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: gcr-admin
  namespace: tekton-pipelines
  annotations:
    replicator.v1.mittwald.de/replicate-from: secrets/gcr-admin
data: {}
EOF
)

secret_docker_gcr=$(cat <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: docker-registry-gcr-admin
  namespace: tekton-pipelines
  annotations:
    replicator.v1.mittwald.de/replicate-from: secrets/docker-registry-gcr-admin
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: e30K
EOF
)

mkdir -p ${replicatedSecretsPath}/tekton-pipelines
echo "${secret_gcr}" > ${replicatedSecretsPath}/tekton-pipelines/gcr-admin.yaml
echo "${secret_docker_gcr}" > ${replicatedSecretsPath}/tekton-pipelines/docker-registry-gcr-admin.yaml

fi
