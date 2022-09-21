#!/bin/bash
set -eou pipefail
## Docs Start ##
## Utils for getting config
## Docs End ##

get_config() {

   get_config_config_path=${1:-""}
   get_config_type=${2:-"f"}
   get_config_name=${3:-"*.yaml"}

   find ${get_config_config_path} -type ${get_config_type} -name "${get_config_name}"
}



get_config_json() {

   get_config_json_config_path=${1:-""}
   get_config_json_type=${2:-"f"}
   get_config_json_name=${3:-"*.yaml"}

   find ${get_config_json_config_path} -type ${get_config_json_type} -name "${get_config_json_name}" | jq --raw-input . | jq --slurp .
}
