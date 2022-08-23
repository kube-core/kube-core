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


if [[ "${cloud_provider}" == "gcp" ]]; then

serviceAccountsConfig="$(cat <<EOF
serviceAccounts:
  - name: cluster-manager
    roles:
      - roles/container.admin
      - roles/container.clusterAdmin
      - roles/container.clusterViewer
      - roles/container.developer
      - roles/compute.admin
  - name: dns-admin
    roles:
      - roles/dns.admin
  - name: gcr-admin
    roles:
      - projects/${project_name}/roles/gcrAdmin
  - name: gcs-admin
    roles:
      - projects/${project_name}/roles/gcsAdmin
  - name: velero
    roles:
      - projects/${project_name}/roles/velero
  - name: thanos
    roles:
      - roles/storage.objectAdmin
  - name: tekton
    roles:
      - roles/container.admin
      - roles/container.clusterAdmin
      - roles/container.clusterViewer
      - roles/container.developer
      - roles/storage.objectAdmin
      - roles/storage.objectViewer
  - name: crossplane
    roles:
      - roles/iam.serviceAccountUser
      - roles/iam.serviceAccountAdmin
      - roles/iam.serviceAccountKeyAdmin
      - roles/cloudsql.admin
      - roles/container.admin
      - roles/redis.admin
      - roles/compute.networkAdmin
      - roles/storage.admin
EOF
)"

gcloud_prepare_sa_roles
gcloud_generate_sa_config
gcloud_setup_velero_bucket
gcloud_setup_thanos_bucket
gcloud_setup_generate_thanos_secret

else
  log_warn "Scripted setup only works with GCP / GKE for now."
fi
