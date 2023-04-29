#!/bin/bash
## Docs Start ##
## Patches all ingresses in a namespace with the input ingress class. Args: ingressClass namespace (default: nginx dev)
## Docs End ##
ingressClass=${1:-"nginx"}
namespace=${2:-"dev"}

ingressList=$(kubectl get ingress -n $namespace --no-headers | awk '{ print $1 }')

echo "${ingressList}" | while read ingress ; do
  kubectl -n $namespace patch ingress $ingress --patch '{"spec": {"ingressClassName": "'"$ingressClass"'"}}'
done
