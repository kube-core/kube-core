#!/bin/bash
## Docs Start ##
## Injects istio in all namespaces. Args: enabled|disabled
## Docs End ##
namespace=${1:-"dev"}
kubectl -n ${namespace} get deploy --no-headers | awk '{print $1}' | xargs kubectl -n ${namespace} rollout restart deploy
kubectl -n ${namespace} get sts --no-headers | awk '{print $1}' | xargs kubectl -n ${namespace} rollout restart sts
