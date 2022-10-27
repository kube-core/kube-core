#!/bin/bash
set -eou pipefail

# Current Script
currentScript=${BASH_SOURCE[0]}
currentScriptPath="$( cd "$( dirname "${currentScript}" )" >/dev/null 2>&1 && pwd )"
currentScriptShortPath=$(echo "${currentScriptPath}" | awk '{split($0, a, "/scripts/"); print a[2]}')

env=${1:-"default"}

corePath="${currentScriptPath}/.."
layersPath="${corePath}/envs/${env}/core/config"

# List layers, make path relative for helmfile context, transforms into an JSON array, then to YAML
layers=$(find ${layersPath} -type f -name '*.yaml' -o -name '*.yaml.gotmpl')

if [[ ! -z "${layers}" ]]; then
  echo "${layers}" | sed 's|.*\/\.\./|./|' | jq -R '[.]' | jq -s 'add' | yq e '.' - -P
fi


####################
# Dynamic injection of all layers in "./env/default/core/config"
# {{ exec "bash" (list "-c" (printf "./scripts/read-layers.sh %s" "default")) | indent 0 | trim }}
####################
