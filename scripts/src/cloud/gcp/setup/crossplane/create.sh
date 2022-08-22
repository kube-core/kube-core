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


serviceAccount="${cluster_config_name}-crossplane"
credentialsFile="${secrets_path}/input/crossplane-system/${serviceAccount}.json"

# enable Kubernetes API
gcloud --project ${project_name} services enable container.googleapis.com && true

# enable CloudSQL API
gcloud --project ${project_name} services enable sqladmin.googleapis.com && true

# enable Redis API
gcloud --project ${project_name} services enable redis.googleapis.com && true

# enable Compute API
gcloud --project ${project_name} services enable compute.googleapis.com && true

# enable Service Networking API
gcloud --project ${project_name} services enable servicenetworking.googleapis.com && true

# enable Additional APIs needed for the example or project
# See `gcloud services list` for a complete list && true

# create service account
gcloud --project ${project_name} iam service-accounts create ${serviceAccount} --display-name "Crossplane Service Account" && true

# export service account email
export fullSA="${serviceAccount}@${project_name}.iam.gserviceaccount.com"

# assign roles
gcloud projects add-iam-policy-binding ${project_name} --member "serviceAccount:$fullSA" --role="roles/iam.serviceAccountUser" && true
gcloud projects add-iam-policy-binding ${project_name} --member "serviceAccount:$fullSA" --role="roles/iam.serviceAccountAdmin" && true
gcloud projects add-iam-policy-binding ${project_name} --member "serviceAccount:$fullSA" --role="roles/iam.serviceAccountKeyAdmin" && true
gcloud projects add-iam-policy-binding ${project_name} --member "serviceAccount:$fullSA" --role="roles/cloudsql.admin" && true
gcloud projects add-iam-policy-binding ${project_name} --member "serviceAccount:$fullSA" --role="roles/container.admin" && true
gcloud projects add-iam-policy-binding ${project_name} --member "serviceAccount:$fullSA" --role="roles/redis.admin" && true
gcloud projects add-iam-policy-binding ${project_name} --member "serviceAccount:$fullSA" --role="roles/compute.networkAdmin" && true
gcloud projects add-iam-policy-binding ${project_name} --member "serviceAccount:$fullSA" --role="roles/storage.admin" && true

# create service account key (this will create a `gcp-key.json` file in your current working directory)
gcloud --project ${project_name} iam service-accounts keys create --iam-account $fullSA ${credentialsFile} && true
