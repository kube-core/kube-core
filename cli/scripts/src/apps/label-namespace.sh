#!/bin/bash
## Docs Start ##
## Adds a label to one namespaces. Args: namespace label value (default: dev istio-injection enabled)
## Docs End ##
namespace=${1:-"dev"}
label=${2:-"istio-injection"}
value=${3:-"enabled"}

kubectl label --overwrite namespace ${namespace} ${label}=${value}
