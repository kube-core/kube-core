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


serviceAccount="cluster-manager"
credentialsFile="$secrets_path/input/cluster-manager.json"

# Create ServiceAccount
gcloud iam service-accounts create ${serviceAccount} --project ${project_name} || true

# Attach the role to the newly create Google Service Account
gcloud projects add-iam-policy-binding ${project_name} \
  --member=serviceAccount:${serviceAccount}@${project_name}.iam.gserviceaccount.com \
  --role=roles/container.admin

gcloud projects add-iam-policy-binding ${project_name} \
  --member=serviceAccount:${serviceAccount}@${project_name}.iam.gserviceaccount.com \
  --role=roles/container.clusterAdmin
  
gcloud projects add-iam-policy-binding ${project_name} \
  --member=serviceAccount:${serviceAccount}@${project_name}.iam.gserviceaccount.com \
  --role=roles/container.clusterViewer
  
gcloud projects add-iam-policy-binding ${project_name} \
  --member=serviceAccount:${serviceAccount}@${project_name}.iam.gserviceaccount.com \
  --role=roles/container.developer
    
gcloud projects add-iam-policy-binding ${project_name} \
  --member=serviceAccount:${serviceAccount}@${project_name}.iam.gserviceaccount.com \
  --role=roles/compute.admin
  
# Delete old keys
keys=$(gcloud iam service-accounts keys list --iam-account=${serviceAccount}@${project_name}.iam.gserviceaccount.com | tail -n +2 | awk '{print $1}')
while read i; do gcloud iam service-accounts keys delete --iam-account=${serviceAccount}@${project_name}.iam.gserviceaccount.com --quiet $i ;done <<< "$keys" || true
# Get key
gcloud iam service-accounts keys create ${credentialsFile} --iam-account ${serviceAccount}@${project_name}.iam.gserviceaccount.com