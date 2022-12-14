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
## Generates a kubeconfig for a GKE cluster, and sets up local access to this cluster
## Docs End ##

gcloud container clusters get-credentials ${cluster_config_name} --zone ${cloud_default_location} --project ${project_name}
kubectl config delete-context ${cluster_config_name} || true
kubectl config rename-context gke_${project_name}_${cloud_default_location}_${cluster_config_name} ${cluster_config_name}

kubectl config view --raw --minify | sed 's/cmd-path.*/cmd-path: gcloud/' > ${secrets_path}/input/kubeconfig.yaml

# Getting Internal API Endpoint
echo "Getting Internal API Endpoint..."
kubectl delete pod devops-tools  || true
endpoint=$( { kubectl run devops-tools --image=${utils_image} --restart=Never && while [[ $(kubectl get pods devops-tools -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do sleep 1; done } > /dev/null && kubectl exec devops-tools -- env | grep KUBERNETES_SERVICE_HOST | awk '{split($0, a, "=" ); print a[2]}' )
kubectl delete pod devops-tools  || true

echo "Endpoint found: $endpoint"
ESCAPED_REPLACE=$(echo -n $endpoint | sed -e 's|[\.]|\\.|g')
cat ${secrets_path}/input/kubeconfig.yaml | sed "s|server.*|server: https://${ESCAPED_REPLACE}|" > ${secrets_path}/input/kubeconfig-internal-gcloud.yaml


# endpoint="10.123.23.10"

# ESCAPED_REPLACE=$(sed -e 's/[\.]/\\./g')
# echo "server: abc" | sed "s|server.*|server: ${ESCAPED_REPLACE}|"
