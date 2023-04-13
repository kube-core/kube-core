#!/bin/bash
## Docs Start ##
## Injects istio in all namespaces. Args: enabled|disabled
## Docs End ##
ingressClass=${1:-"nginx"}

ingressList=$(kubectl get ingress -A --no-headers | awk '{ print $1" "$2 }')

echo "${ingressList}" | while read ns ingress ; do
  kubectl -n $ns patch ingress $ingress --patch '{"spec": {"ingressClassName": "'"$ingressClass"'"}}'
done
