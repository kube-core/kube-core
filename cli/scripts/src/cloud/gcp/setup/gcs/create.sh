#!/bin/bash
# set -eou pipefail

# load conf from yaml
currentScriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
clusterConfigPath=$(eval find ./$(printf "{$(echo %{1..7}q,)}" | sed 's/ /\.\.\//g') -maxdepth 1 -name cluster-config.yaml | head -n 1 | xargs realpath)
clusterConfigDir=$(dirname ${clusterConfigPath})
eval $(sed -e 's/\(.*\) #.*/\1/g;s/:[^:\/\/]/="/g;s/$/"/g;s/ *=/=/g' ${clusterConfigPath})

serviceAccount="gcs-admin"
credentialsFile="${secrets_path}/input/gcs-admin.json"


# Create Buckets
# gsutil mb --pap enforced -l ${cloud_default_location} -p ${project_name} gs://default-bucket || true


# Create ServiceAccount
gcloud iam service-accounts create ${serviceAccount} --project ${project_name}

# Create a role with the required permissions
gcloud iam roles create gcsAdmin \
  --project ${project_name} \
  --permissions=storage.objects.get,storage.objects.create,storage.objects.list,storage.objects.update,storage.objects.delete,storage.buckets.create,storage.buckets.get


# Attach the role to the newly create Google Service Account
gcloud projects add-iam-policy-binding ${project_name} \
  --member=serviceAccount:${serviceAccount}@${project_name}.iam.gserviceaccount.com \
  --role=projects/${project_name}/roles/gcsAdmin

# Delete old keys
keys=$(gcloud iam service-accounts keys list --iam-account=${serviceAccount}@${project_name}.iam.gserviceaccount.com | tail -n +2 | awk '{print $1}')
while read i; do gcloud iam service-accounts keys delete --iam-account=${serviceAccount}@${project_name}.iam.gserviceaccount.com --quiet $i ;done <<< "$keys"
# Get key
gcloud iam service-accounts keys create ${credentialsFile} --iam-account ${serviceAccount}@${project_name}.iam.gserviceaccount.com


# imagePullSecrets
# kubectl --namespace default create secret docker-registry gcs-admin \
#   --docker-server=eu.gcs.io \
#   --docker-username=_json_key \
#   --docker-password="$(cat keyfile.json)"
