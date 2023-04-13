#!/bin/bash
## Docs Start ##
## Injects istio in all namespaces. Args: enabled|disabled
## Docs End ##
istioInjection=${1:-"enabled"}

nsList=$(kubectl get ns --no-headers | awk '{ print $1 }')

echo "${nsList}" | while read ns ; do
    echo "$ns"
    kubectl label --overwrite namespace ${ns} istio-injection=${istioInjection}
    deployments=$(kubectl -n $ns get deployments --no-headers)
    statefulsets=$(kubectl -n $ns get statefulsets --no-headers)
    if [[ ! -z "$deployments" ]]; then
        echo $deployments | awk '{print $1}' | xargs kubectl -n $ns rollout restart deployments
    fi
    if [[ ! -z "$statefulsets" ]]; then
        echo $statefulsets | awk '{print $1}' | xargs kubectl -n $ns rollout restart statefulsets
    fi


    ingressList=$(kubectl -n $ns get ingress --no-headers | awk '{print $1}')
    if [[  ! -z $ingressList ]]; then
        echo "${ingressList}" | while read ingress ; do
            ingressClass=nginx-istio
            if [[ "$istioInjection" == "enabled" ]]; then
                kubectl -n $ns patch ingress $ingress --patch '{"spec": {"ingressClassName": "'"$ingressClass"'-istio"}}'
            else
                kubectl -n $ns patch ingress $ingress --patch '{"spec": {"ingressClassName": "'"$ingressClass"'"}}'
            fi
        done
    fi
done
