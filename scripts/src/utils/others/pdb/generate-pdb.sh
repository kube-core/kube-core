#!/bin/bash
set -eou pipefail

currentScriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
clusterConfigPath=$(eval find ./$(printf "{$(echo %{1..7}q,)}" | sed 's/ /\.\.\//g') -maxdepth 1 -name cluster-config.yaml | head -n 1 | xargs realpath)
clusterConfigDir=$(dirname ${clusterConfigPath})
eval $(sed -e 's/\(.*\) #.*/\1/g;s/:[^:\/\/]/="/g;s/$/"/g;s/ *=/=/g' ${clusterConfigPath})

# kubectl --context=${cluster_config_name} apply -R -f ${currentScriptPath}/../config/

# Disabled for now
exit 0

deployments=$(kubectl get deploy,sts -A -o json | jq -r '.items[] | "\(.metadata.namespace) \(.metadata.name) \(.spec.replicas)"' | grep -vE "kube\-system")

# echo $deployments

while read i
do 
    ns=$(echo $i | awk '{print $1}')
    name=$(echo $i | awk '{print $2}')
    replicas=$(echo $i | awk '{print $3}')

    # echo $i

    pdb=$(cat <<EOF
apiVersion: policy/v1beta1
kind: PodDisruptionBudget
metadata:
  name: ${name}
  namespace: ${ns}
spec:
  minAvailable: 1
  selector:
    matchLabels:
      app: ${name}

EOF
)

# echo "$pdb"
echo "Generating PDB for ${ns}/${name}"
outputPath=${currentScriptPath}/generated/${ns}/pdb
mkdir -p ${outputPath}
echo "$pdb" > ${outputPath}/pdb-${name}.yaml

# cat ${outputPath} | kubectl apply -f - 

done <<< "$deployments"


