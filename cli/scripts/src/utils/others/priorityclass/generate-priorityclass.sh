#!/bin/bash
set -eou pipefail
## Docs Start ##
## Generates priorityclass for all deployments in cluster
## Docs End ##

currentScriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
clusterConfigPath=$(eval find ./$(printf "{$(echo %{1..7}q,)}" | sed 's/ /\.\.\//g') -maxdepth 1 -name cluster-config.yaml | head -n 1 | xargs realpath)
clusterConfigDir=$(dirname ${clusterConfigPath})
eval $(sed -e 's/\(.*\) #.*/\1/g;s/:[^:\/\/]/="/g;s/$/"/g;s/ *=/=/g' ${clusterConfigPath})

# kubectl --context=${cluster_config_name} apply -R -f ${currentScriptPath}/../config/

data=$(cat ${currentScriptPath}/config.json | jq -r '.[] | "\(.name) \(.value)"')


while read i
do
  # echo $i
  name=$(echo $i | awk '{print $1}')
  value=$(echo $i | awk '{print $2}')

  if [[ "${name}" == *"high"* || "${name}" == *"critical"* ]]
  then
    pc=$(cat <<EOF
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: ${name}
value: ${value}
description: "PriorityClass for ${name}"
EOF
)
  else
    pc=$(cat <<EOF
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: ${name}
value: ${value}
preemptionPolicy: Never
description: "PriorityClass for ${name}"
EOF
)
  fi

echo "Generating PriorityClass ${value}-${name}"
outputPath=${currentScriptPath}/generated/system/priorityclass/
mkdir -p ${outputPath}
echo "$pc" > ${outputPath}/pc-${value}-${name}.yaml

done <<< "$data"
