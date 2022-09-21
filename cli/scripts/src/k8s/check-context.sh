#!/bin/
## Docs Start ##
## Checks if input context matches current cluster config. Args: context
## Docs End ##
set -eou pipefail

check_context() {

   context=$(kubectl config current-context)

   if [[ "$1" !=  "${context}" ]]
   then
      log_error "Cluster context ${context} doesn't match with ${1}, aborting !"
      exit 2
   fi

}
