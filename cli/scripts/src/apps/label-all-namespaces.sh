#!/bin/bash
## Docs Start ##
## Injects istio in all namespaces. Args: enabled|disabled
## Docs End ##
label=${1:-"istio-injection"}
value=${2:-"enabled"}

nsList=$(kubectl get ns --no-headers | awk '{ print $1 }')

echo "${nsList}" | while read ns ; do
    kubectl label --overwrite namespace ${ns} ${label}=${value}
done
