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


serviceAccount="tekton"
mkdir -p ${secrets_path}/input/tekton-pipelines
credentialsFile="${secrets_path}/input/tekton-pipelines/tekton.json"

# gsutil mb -p ${project_name} gs://${cluster_name}-tekton-storage || true

# Create ServiceAccount
gcloud iam service-accounts create ${serviceAccount} --project ${project_name} || true

# Attach the role to the newly create Google Service Account
gcloud projects add-iam-policy-binding ${project_name} \
  --member=serviceAccount:${serviceAccount}@${project_name}.iam.gserviceaccount.com \
  --role=roles/container.admin || true

gcloud projects add-iam-policy-binding ${project_name} \
  --member=serviceAccount:${serviceAccount}@${project_name}.iam.gserviceaccount.com \
  --role=roles/container.clusterAdmin || true
  
gcloud projects add-iam-policy-binding ${project_name} \
  --member=serviceAccount:${serviceAccount}@${project_name}.iam.gserviceaccount.com \
  --role=roles/container.clusterViewer || true
  
gcloud projects add-iam-policy-binding ${project_name} \
  --member=serviceAccount:${serviceAccount}@${project_name}.iam.gserviceaccount.com \
  --role=roles/container.developer || true
  
gcloud projects add-iam-policy-binding ${project_name} \
  --member=serviceAccount:${serviceAccount}@${project_name}.iam.gserviceaccount.com \
  --role=roles/storage.objectAdmin || true
  
gcloud projects add-iam-policy-binding ${project_name} \
  --member=serviceAccount:${serviceAccount}@${project_name}.iam.gserviceaccount.com \
  --role=roles/storage.objectViewer || true
  
  

# Delete old keys
keys=$(gcloud iam service-accounts keys list --iam-account=${serviceAccount}@${project_name}.iam.gserviceaccount.com | tail -n +2 | awk '{print $1}') || true
while read i; do gcloud iam service-accounts keys delete --iam-account=${serviceAccount}@${project_name}.iam.gserviceaccount.com --quiet $i ;done <<< "$keys" || true
# Get key
gcloud iam service-accounts keys create ${credentialsFile} --iam-account ${serviceAccount}@${project_name}.iam.gserviceaccount.com || true


# Generate kubeconfig for tekton - TODO : Automate it
# gcloud auth activate-service-account --key-file=${credentialsFile}
# gcloud container clusters get-credentials ${cluster_config_name} --zone ${cloud_default_location} --project ${project_name} --internal-ip

# kubectl config delete-context ${cluster_config_name} || true
# kubectl config rename-context gke_${project_name}_${cloud_default_location}_${cluster_config_name} ${cluster_config_name}

# kubectl config view --raw --minify | sed 's/cmd-path.*/cmd-path: gcloud/' > secrets/input/kubeconfig-internal-gcloud.yaml

