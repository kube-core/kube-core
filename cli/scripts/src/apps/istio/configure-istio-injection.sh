#!/bin/bash
## Docs Start ##
## Injects istio in all namespaces. Args: enabled|disabled
## Docs End ##
istioInjection=${1:-"enabled"}

nsList=$(kubectl get ns --no-headers | awk '{ print $1 }')

echo "${nsList}" | while read ns ; do
    kubectl label --overwrite namespace ${ns} istio-injection=${istioInjection}
done
