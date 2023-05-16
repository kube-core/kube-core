#!/bin/bash
set -eou pipefail

# Current Script
currentScript=${BASH_SOURCE[0]}
currentScriptPath="$( cd "$( dirname "${currentScript}" )" >/dev/null 2>&1 && pwd )"
currentScriptShortPath=$(echo "${currentScriptPath}" | awk '{split($0, a, "/scripts/"); print a[2]}')

corePath="${currentScriptPath}/.."

fileList="${1}"
localValuesPath="${2}"

fileList=$(echo "$fileList" |  yq -P -o j | jq -r '.[]')
localValuesPath=$(echo "$localValuesPath")

if [[ "$fileList" != "" ]]; then
  while read filePath; do
    filePath=$(echo $filePath | xargs)
    data=$(cat $filePath | yq -o j -P | jq -c -r -j)
    shortPath=$(echo -n $filePath | sed "s|${localValuesPath}/||")

    echo $shortPath | jq --raw-input '.' | jq -s | jq --argjson data "$(echo $data)" -c 'reduce .[] as $entry ({}; ($entry | sub("\\.yaml";"") | sub("\\.json";"") | sub("\\.";"/") | split("/") ) as $names | $names[0:-1] as $p | setpath($p; getpath($p) + {($names[-1]): $data}) )'

  done <<< "$fileList" | jq -n 'reduce inputs as $i ({}; . * $i)' | yq '.local.values' -P
fi
####################
# {{ exec "bash" (list "-c" (printf "find ../local/values/ -type f | xargs realpath | jq --raw-input '.' | jq -s -c")) | indent 6 | trim }}
####################
