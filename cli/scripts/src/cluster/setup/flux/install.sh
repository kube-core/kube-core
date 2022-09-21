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
## Generates secrets and prints instructions to install flux
## Docs End ##

log_info "Installing Flux!"

secretName="flux-ssh"
mkdir -p ${keys_path}
if [[ ! -f "${keys_path}/.${secretName}-key" ]]; then
    log_info "Generating new SSH key for flux..."
    ssh-keygen -t rsa -N '' -q -f ${keys_path}/.${secretName}-key
    log_info "Flux SSH key generated!"
    log_warn "You need to add ${keys_path}/.${secretName}-key.pub as a deploy key to your repositories!"
fi

secret=$(kubectl create secret generic ${secretName} --dry-run=client -o yaml --from-file=identity=${keys_path}/.${secretName}-key --from-file=identity.pub=${keys_path}/.${secretName}-key.pub --from-file=known_hosts=${keys_path}/.git-ssh-hosts  | yq '.metadata |= {"name": "'"${secretName}"'", "namespace": "secrets", "annotations" : {"replicator.v1.mittwald.de/replication-allowed": "true", "replicator.v1.mittwald.de/replication-allowed-namespaces": "*"}}' -)

echo "${secret}" > ${secrets_path}/manifests/${secretName}.yaml

# if [[ "${install_flux}" == "true" ]]
# then
#     echo "Installing Flux2..."
#     echo "WARNING: Flux2 is installed with kubectl !"
#     kubectl apply -R -f ${localConfig_path}/flux-system --wait
# else
#     echo "WARNING: Not installing flux. Removing config inherited from generation"
#     rm -rf ${localConfig_path}/flux-system
# fi

# if [[ "${install_gitops}" == "true" ]]
# then

# echo "Config - Flux - Source"
# echo "To install your cluster's source, you can run:"
# echo "flux create source git ${cluster_config_name} --url=${gitops_repository} --branch=${gitops_ref} --interval=${gitops_refresh} --private-key-file ${gitops_ssh_key}"

# echo "Config - Flux - Kustomization"
# echo "To install some apps, you can run:"
# echo "flux create kustomization ${cluster_config_name} --source=GitRepository/${cluster_config_name} --path=".${gitops_path}" --prune=true --interval=${gitops_refresh} --validation=client"

# echo "Config - GCR - Notifications (https://cloud.google.com/container-registry/docs/configuring-notifications)"
# echo "To create a topic:"
# # echo "gcloud pubsub topics create ${cluster_config_name}-gcr --project=${cloud_project}"
# echo "gcloud pubsub topics create gcr --project=${cloud_project}"

# echo "To create a subscription for the cluster:"
# # echo "gcloud pubsub subscriptions create ${cluster_config_name}-flux-gcr-receiver --topic=${cluster_config_name}-gcr --project=${cloud_project}"
# echo "gcloud pubsub subscriptions create ${cluster_config_name}-flux-gcr-receiver --topic=gcr --project=${cloud_project}"

# echo "To create SA for Flux:"
# serviceAccount="${cluster_config_name}-flux"
# echo "gcloud iam service-accounts create ${serviceAccount} --project ${cloud_project}"

# echo "To add permissions for Flux SA to subscribe to topics:"
# echo "gcloud projects add-iam-policy-binding ${cloud_project} --member=serviceAccount:${serviceAccount}@${cloud_project}.iam.gserviceaccount.com --role=roles/pubsub.subscriber"

# echo "To create a key for Flux SA:"
# credentialsFile="${secrets_path}/input/flux-system/flux.json"
# echo "gcloud iam service-accounts keys create ${credentialsFile} --iam-account ${serviceAccount}@${cloud_project}.iam.gserviceaccount.com"
# # flux create image repository podinfo --image=ghcr.io/stefanprodan/podinfo --interval=1m


# echo "To create a webhook token for gcr push receiver"
# token=$(head -c 12 /dev/urandom | shasum | cut -d ' ' -f1)

# echo "kubectl create secret generic webhook-token -n flux-system --from-literal=token=${token}"

# echo "To generate a visitorgroup to allow GCP to push on Flux webhook:"
# region="europe"
# sourceRanges=$(curl --silent https://www.gstatic.com/ipranges/cloud.json | jq -r '.prefixes[] | select(.ipv4Prefix) | select(.scope | contains("'${region}'")) | {"cidr": .ipv4Prefix, "name": "\(.service) - \(.scope)"}' | jq -s '{sources: .}' | yq e - -P)


# visitorGroup=$(cat <<EOF
# apiVersion: ingress.neo9.io/v1
# kind: VisitorGroup
# metadata:
#   name: gcp
# spec:
#   ${sourceRanges}
# EOF
# )

# echo "${visitorGroup}" > visitorgroup-gcp.yaml



# log_info "Done Installing Flux!"
