## Docs Start ##
## Gets logs of all pods in crash state
## Docs End ##
while read namespace pod
do
    echo $namespace
    echo $pod

    mkdir -p ./.crash-logs/${namespace}

    kubectl logs -n ${namespace} ${pod} >> ./.crash-logs/${namespace}/${pod}

done <<< "$(kubectl get pods -A --no-headers | grep CrashLoopBackOff | awk '{print $1" "$2}')"
