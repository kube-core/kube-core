## Docs Start ##
## Generates HPAs for all deployments in cluster
## Docs End ##

deployments=$(kubectl get deploy -A -o json | jq -r '.items[] | "\(.metadata.namespace) \(.metadata.name) \(.spec.replicas)"' | grep -vE "kube\-system" | grep -E "2$")

# echo $deployments

while read i
do
    ns=$(echo $i | awk '{print $1}')
    name=$(echo $i | awk '{print $2}')
    replicas=$(echo $i | awk '{print $3}')

    # echo $i

    hpa=$(cat <<EOF
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  name: ${name}
  namespace: ${ns}
spec:
  maxReplicas: 6
  minReplicas: 2
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: ${name}
  targetCPUUtilizationPercentage: 90
EOF
)

echo "$hpa"

done <<< "$deployments"
