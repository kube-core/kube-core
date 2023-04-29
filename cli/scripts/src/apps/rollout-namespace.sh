#!/bin/bash
## Docs Start ##
## Rolls out all pods and statefulsets in a namespace. Args: namespace
## Docs End ##
namespace=${1:-"dev"}
kubectl -n ${namespace} get deploy --no-headers | awk '{print $1}' | xargs kubectl -n ${namespace} rollout restart deploy
kubectl -n ${namespace} get sts --no-headers | awk '{print $1}' | xargs kubectl -n ${namespace} rollout restart sts
