#!/bin/bash
# set -eou pipefail

# load conf from yaml
currentScriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
clusterConfigPath=$(eval find ./$(printf "{$(echo %{1..7}q,)}" | sed 's/ /\.\.\//g') -maxdepth 1 -name cluster-config.yaml | head -n 1 | xargs realpath)
clusterConfigDir=$(dirname ${clusterConfigPath})
eval $(sed -e 's/\(.*\) #.*/\1/g;s/:[^:\/\/]/="/g;s/$/"/g;s/ *=/=/g' ${clusterConfigPath})

serviceAccount="dns-admin"
credentialsFile="secrets/input/dns-admin.json"

gcloud iam service-accounts delete --quiet ${serviceAccount}@${project_name}.iam.gserviceaccount.com --project ${project_name}

rm -rf ${credentialsFile}