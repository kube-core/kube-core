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


log_info "${project_name} - Building: local/secrets/input -> local/secrets/output..."

configPath=${config_path}
localConfigPath=${localConfig_path}
buildPath=${build_path}

secretsPath=${secrets_path}/output
replicatedSecretsPath=${secrets_path}/replicated

inputPath="${secrets_path}/input"
outputPath="${secrets_path}/output"
manifestsPath="${secrets_path}/manifests"
tmpOutputPath="${tmpFolder}/local/secrets/output"

mkdir -p ${tmpOutputPath}

filter=${1:-""}

inputList=$(find ${inputPath} -type f)

if [[ "$filter" != "" ]] ; then
  inputList=$(echo "${inputList}" | grep ${filter}) || true
fi


if [[ ! -z "${inputList}" ]] ; then

echo "${inputList}" | grep -v .gitkeep | while read f; do

  log_debug "Processing $f file..."

  namespace=$(dirname $f | xargs basename)
  if [[ "${namespace}" == "input" ]]
  then
    namespace="secrets"
  fi
  secretName=$(basename $f)
  name=$(echo "$secretName" | cut -f 1 -d '.')

  log_debug "Generating secret: ${name}"

  mkdir -p  ${tmpOutputPath}/${namespace}/secrets
  mkdir -p  ${outputPath}/${namespace}/secrets

  kubectl create secret generic ${name} \
    --namespace=${namespace} \
    --dry-run=client \
    --from-file=${f} \
    -o yaml | \
  ${scripts_k8s_secrets_seal_path} | \
  namespace="${namespace}" yq e '.metadata.namespace = env(namespace)' - > ${tmpOutputPath}/${namespace}/secrets/${name}.yaml
  mv -f ${tmpOutputPath}/${namespace}/secrets/${name}.yaml ${outputPath}/${namespace}/secrets/${name}.yaml

done || true
fi

log_debug "Inputs Done"

manifestsList=$(find ${manifestsPath} -type f)

if [[ "$filter" != "" ]] ; then
  manifestsList=$(echo "${manifestsList}" | grep ${filter}) || true
fi

if [[ ! -z "${manifestsList}" ]] ; then

echo "${manifestsList}" | grep -v .gitkeep | while read f; do

  log_debug "Processing $f file..."

  namespace=$(dirname $f | xargs basename)
  if [[ "${namespace}" == "manifests" ]]
  then
    namespace="secrets"
  fi
  secretName=$(basename $f)
  name=$(echo "$secretName" | cut -f 1 -d '.')

  log_debug "Generating secret: ${name}"

  mkdir -p  ${tmpOutputPath}/${namespace}/secrets
  mkdir -p  ${outputPath}/${namespace}/secrets

  cat ${f} | \
  ${scripts_k8s_secrets_seal_path} | \
  namespace="${namespace}" yq e '.metadata.namespace = env(namespace)' - > ${tmpOutputPath}/${namespace}/secrets/${name}.yaml
  mv -f ${tmpOutputPath}/${namespace}/secrets/${name}.yaml ${outputPath}/${namespace}/secrets/${name}.yaml

done || true
fi

log_debug "Manifests Done"

# Generate custom if exists
if [[ -f "${secrets_path}/generate-custom.sh" ]] ; then
  ${secrets_path}/generate-custom.sh || true
fi

# mv -f ${tmpOutputPath} ${outputPath}
rm -rf ${tmpOutputPath}

# git add ${outputPath} && git commit -m "chore: Updates secrets (by secrets/generate.sh)"

log_info "${project_name} - Done Building: local/secrets/input -> local/secrets/output"
