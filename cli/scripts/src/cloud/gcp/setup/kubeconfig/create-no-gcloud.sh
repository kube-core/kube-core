#!/bin/bash
## Docs Start ##
## Generates a kubeconfig for a GKE cluster (without gcloud cli auth proxy)
## Docs End ##
# set -eou pipefail

# load conf from yaml
currentScriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
clusterConfigPath=$(eval find ./$(printf "{$(echo %{1..7}q,)}" | sed 's/ /\.\.\//g') -maxdepth 1 -name cluster-config.yaml | head -n 1 | xargs realpath)
clusterConfigDir=$(dirname ${clusterConfigPath})
eval $(sed -e 's/\(.*\) #.*/\1/g;s/:[^:\/\/]/="/g;s/$/"/g;s/ *=/=/g' ${clusterConfigPath})


GET_CMD="gcloud container clusters describe ${cluster_config_name} --project=${project_name} --zone=${cloud_default_location}"

cat > ${secrets_path}/input/kubeconfig-no-gcloud.yaml <<EOF
apiVersion: v1
kind: Config
current-context: ${cluster_config_name}
contexts: [{name: ${cluster_config_name}, context: {cluster: ${cluster_config_name}, user: ${cluster_config_name}}}]
users: [{name: ${cluster_config_name}, user: {auth-provider: {name: gcp}}}]
clusters:
- name: ${cluster_config_name}
  cluster:
    server: "https://$(eval "$GET_CMD --format='value(endpoint)'")"
    certificate-authority-data: "$(eval "$GET_CMD --format='value(masterAuth.clusterCaCertificate)'")"
EOF
