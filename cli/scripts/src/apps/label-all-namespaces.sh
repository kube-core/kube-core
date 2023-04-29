#!/bin/bash
## Docs Start ##
## Adds a label to all namespaces. Args: label value (default: istio-injection enabled)
## Docs End ##
label=${1:-"istio-injection"}
value=${2:-"enabled"}

nsList=$(kubectl get ns --no-headers | awk '{ print $1 }')

echo "${nsList}" | while read ns ; do
    kubectl label --overwrite namespace ${ns} ${label}=${value}
done
