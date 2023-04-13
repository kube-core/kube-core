#!/bin/bash
## Docs Start ##
## Injects istio in all namespaces. Args: enabled|disabled
## Docs End ##
namespace=${1:-"dev"}
label=${2:-"istio-injection"}
value=${3:-"enabled"}

kubectl label --overwrite namespace ${namespace} ${label}=${value}
