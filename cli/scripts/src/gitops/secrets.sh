#!/bin/bash
set -eou pipefail

## Header Start

# Current Script
currentScript=${BASH_SOURCE[0]}
currentScriptPath="$( cd "$( dirname "${currentScript}" )" >/dev/null 2>&1 && pwd )"
currentScriptShortPath=$(echo "${currentScriptPath}" | awk '{split($0, a, "/scripts/"); print a[2]}')

# Cluster Config
if [[ ! -z $(find ./cluster-config.yaml 2> /dev/null) ]]; then
    clusterConfigPath=$(echo ./cluster-config.yaml | head -n 1 | xargs realpath 2> /dev/null)
else
    clusterConfigPath=$(eval find ./$(printf "{$(echo %{1..7}q,)}" | sed 's/ /\.\.\//g') -maxdepth 1 -name cluster-config.yaml | head -n 1 | xargs realpath 2> /dev/null) || true
fi
if [[ -z "${clusterConfigPath}" ]] ; then
    echo "Stopping ${currentScript}"
    echo "This script requires to be in a cluster context, but cluster-config.yaml not found in parent directories"
    exit 0
fi

clusterConfigDirPath=$(dirname ${clusterConfigPath} | xargs realpath)
helmfilePath="${clusterConfigDirPath}/helmfile.yaml"
tmpFolder="${clusterConfigDirPath}/.kube-core/.tmp"

# Cluster Scripts
if [[ ! -z $(find ${currentScriptPath}/scripts-config.yaml 2> /dev/null) ]]; then
    scriptsConfigPath=$(echo ${currentScriptPath}/scripts-config.yaml | head -n 1 | xargs realpath 2> /dev/null)
else
    scriptsConfigPath=$(eval find "${currentScriptPath}"/$(printf "{$(echo %{1..7}q,)}" | sed 's/ /\.\.\//g') -maxdepth 1 -name scripts-config.yaml | head -n 1 | xargs realpath)
fi
scriptsConfigDirPath=$(dirname ${scriptsConfigPath} | xargs realpath)

defaultClusterConfigPath=${scriptsConfigDirPath}/default-cluster-config.yaml
corePath=$(echo ${scriptsConfigDirPath}/../.. | xargs realpath)
coreTmpFolder="${corePath}/.kube-core/.tmp"

# Loading scripts
eval "$(${scriptsConfigDirPath}/src/includes.sh)"

# Loading default-cluster-config.yaml
clusterConfigVars=$(parse_yaml ${defaultClusterConfigPath})
clusterConfigVars=$(echo "${clusterConfigVars}" | sed "s|\./|${clusterConfigDirPath}/|")
eval "${clusterConfigVars}"

# Loading cluster-config.yaml
clusterConfigVars=$(parse_yaml ${clusterConfigPath})
clusterConfigVars=$(echo "${clusterConfigVars}" | sed "s|\./|${clusterConfigDirPath}/|")
eval "${clusterConfigVars}"

# Loading scripts-config.yaml
paths=$(parse_yaml ${scriptsConfigPath})
absolutePaths=$(echo "${paths}" | sed "s|\./|${scriptsConfigDirPath}/|")
eval "${absolutePaths}"

check_requirements
prepare_workspace
check_context "${cluster_config_context}"
# check_args "$@"
## Header End
## Docs Start ##
## Builds local secrets to output and gitops config
## Docs End ##

log_info "Building: local/secrets -> config/namespace/secrets..."

tmpConfigPath=${tmpFolder}/config
configPath=${tmpConfigPath}
localConfigPath=${localConfig_path}
buildPath=${build_path}

secretsPath=${secrets_path}/output
replicatedSecretsPath=${secrets_path}/replicated

log_debug "Generating secrets..."
${scripts_k8s_secrets_generate_path} $@
mkdir -p ${secrets_path}/secrets-releases
cp -rf ${secrets_path}/output/* ${secrets_path}/secrets-releases/

#### COPY DISABLED
# log_debug "Copying secrets..."

# mkdir -p ${configPath}
# rm -rf ${tmpFolder}/secrets
# mkdir -p ${tmpFolder}/secrets

# cd ${secretsPath} &> /dev/null # Remove logs
# secrets=$(find . -type f -name '*.yaml')
# log_insane "List of secrets"
# log_insane "${secrets}"
# if [[ ! -z "${secrets}" ]] ; then
#     echo "${secrets}" | xargs yq '.' > ${tmpFolder}/secrets/secrets.yaml
# fi


# mkdir -p ${replicatedSecretsPath}
# cd ${replicatedSecretsPath} &> /dev/null # Remove logs
# replicatedSecrets=$(find . -type f -name '*.yaml')


# if [[ "${replicatedSecrets}" != "" ]] ; then
#     echo "${replicatedSecrets}" | xargs yq '.' > ${tmpFolder}/secrets/replicated-secrets.yaml
# fi


# if [[ "${run_slice_by_release}" == "true" ]]; then

#     if [[ "$LOG_LEVEL" == "DEBUG" || "$LOG_LEVEL" == "INSANE" ]] ; then
#         if [[ "${secrets}" != "" ]] ; then
#             log_debug "kubectl slice -f ${tmpFolder}/secrets/secrets.yaml --output-dir ${tmpFolder}/secrets/secrets --template='{{(.metadata.labels | index "cluster.kube-core.io/context") |dottodash|replace ":" "-"}}/{{.metadata.namespace}}/{{(.metadata.labels | index "release.kube-core.io/name") |dottodash|replace ":" "-"}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'"
#             kubectl slice -f ${tmpFolder}/secrets/secrets.yaml --output-dir ${tmpFolder}/secrets/secrets --template='{{(.metadata.labels | index "cluster.kube-core.io/context") |dottodash|replace ":" "-"}}/{{.metadata.namespace}}/{{(.metadata.labels | index "release.kube-core.io/name") |dottodash|replace ":" "-"}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'
#         fi
#         if [[ "${replicatedSecrets}" != "" ]] ; then
#             log_debug "kubectl slice -f ${tmpFolder}/secrets/replicated-secrets.yaml --output-dir ${tmpFolder}/secrets/secrets --template='{{(.metadata.labels | index "cluster.kube-core.io/context") |dottodash|replace ":" "-"}}/{{.metadata.namespace}}/{{(.metadata.labels | index "release.kube-core.io/name") |dottodash|replace ":" "-"}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'"
#             kubectl slice -f ${tmpFolder}/secrets/replicated-secrets.yaml --output-dir ${tmpFolder}/secrets/secrets --template='{{(.metadata.labels | index "cluster.kube-core.io/context") |dottodash|replace ":" "-"}}/{{.metadata.namespace}}/{{(.metadata.labels | index "release.kube-core.io/name") |dottodash|replace ":" "-"}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'
#         fi
#     else
#         if [[ "${secrets}" != "" ]] ; then
#             log_debug "kubectl slice -f ${tmpFolder}/secrets/secrets.yaml --output-dir ${tmpFolder}/secrets/secrets --template='{{(.metadata.labels | index "cluster.kube-core.io/context") |dottodash|replace ":" "-"}}/{{.metadata.namespace}}/{{(.metadata.labels | index "release.kube-core.io/name") |dottodash|replace ":" "-"}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml' 2> /dev/null"
#             kubectl slice -f ${tmpFolder}/secrets/secrets.yaml --output-dir ${tmpFolder}/secrets/secrets --template='{{(.metadata.labels | index "cluster.kube-core.io/context") |dottodash|replace ":" "-"}}/{{.metadata.namespace}}/{{(.metadata.labels | index "release.kube-core.io/name") |dottodash|replace ":" "-"}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml' 2> /dev/null
#         fi
#         if [[ "${replicatedSecrets}" != "" ]] ; then
#             log_debug "kubectl slice -f ${tmpFolder}/secrets/replicated-secrets.yaml --output-dir ${tmpFolder}/secrets/secrets --template='{{(.metadata.labels | index "cluster.kube-core.io/context") |dottodash|replace ":" "-"}}/{{.metadata.namespace}}/{{(.metadata.labels | index "release.kube-core.io/name") |dottodash|replace ":" "-"}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml' 2> /dev/null"
#             kubectl slice -f ${tmpFolder}/secrets/replicated-secrets.yaml --output-dir ${tmpFolder}/secrets/secrets --template='{{(.metadata.labels | index "cluster.kube-core.io/context") |dottodash|replace ":" "-"}}/{{.metadata.namespace}}/{{(.metadata.labels | index "release.kube-core.io/name") |dottodash|replace ":" "-"}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml' 2> /dev/null
#         fi
#     fi
# else
#     if [[ "$LOG_LEVEL" == "DEBUG" || "$LOG_LEVEL" == "INSANE" ]] ; then
#         if [[ "${secrets}" != "" ]] ; then
#             log_debug "kubectl slice -f ${tmpFolder}/secrets/secrets.yaml --output-dir ${tmpFolder}/secrets/secrets --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'"
#             kubectl slice -f ${tmpFolder}/secrets/secrets.yaml --output-dir ${tmpFolder}/secrets/secrets --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'
#         fi
#         if [[ "${replicatedSecrets}" != "" ]] ; then
#             log_debug "kubectl slice -f ${tmpFolder}/secrets/replicated-secrets.yaml --output-dir ${tmpFolder}/secrets/secrets --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'"
#             kubectl slice -f ${tmpFolder}/secrets/replicated-secrets.yaml --output-dir ${tmpFolder}/secrets/secrets --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml'
#         fi
#     else
#         if [[ "${secrets}" != "" ]] ; then
#             log_debug "kubectl slice -f ${tmpFolder}/secrets/secrets.yaml --output-dir ${tmpFolder}/secrets/secrets --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml' 2> /dev/null"
#             kubectl slice -f ${tmpFolder}/secrets/secrets.yaml --output-dir ${tmpFolder}/secrets/secrets --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml' 2> /dev/null
#         fi
#         if [[ "${replicatedSecrets}" != "" ]] ; then
#             log_debug "kubectl slice -f ${tmpFolder}/secrets/replicated-secrets.yaml --output-dir ${tmpFolder}/secrets/secrets --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml' 2> /dev/null"
#             kubectl slice -f ${tmpFolder}/secrets/replicated-secrets.yaml --output-dir ${tmpFolder}/secrets/secrets --template='{{.metadata.namespace}}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml' 2> /dev/null
#         fi
#     fi
# fi

# cp -fr ${tmpFolder}/secrets/secrets/* ${configPath} 2>/dev/null || true

# cp -rf ${configPath}/* ${config_path} 2>/dev/null || true

# log_info "Deleting empty files..."
# emptyFiles=$(find ${config_path} -name ".yaml")

# if [[ "${emptyFiles}" != "" ]]; then
#     log_debug "Empty files found, deleting them! You probably need to check the templating using debug mode."
#     log_insane "${emptyFiles}"
#     echo "${emptyFiles}" | xargs rm -rf
# fi
#### COPY DISABLED


log_debug "Done Building: local/secrets -> config/namespace/secrets..."
