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
## Generates configmaps from input to output
## Docs End ##

log_info "Building: local/configmaps/input -> local/configmaps/output..."

inputPath="${configmaps_path}/input"
outputPath="${configmaps_path}/output"
manifestsPath="${configmaps_path}/manifests"
tmpOutputPath="${tmpFolder}/local/configmaps/output"

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
    namespace="configmaps"
  fi
  configMapName=$(basename $f)
  name=$(echo "$configMapName" | cut -f 1 -d '.')

  log_debug "Generating ConfigMap: ${name}"

  mkdir -p  ${tmpOutputPath}/${namespace}/configmaps/
  mkdir -p  ${outputPath}/${namespace}/configmaps/

  kubectl create configmap ${name} \
    --namespace ${namespace} \
    --dry-run=client \
    --from-file=${f} -o yaml |
    yq eval -o json - | jq '.metadata |= ({annotations: {"replicator.v1.mittwald.de/replication-allowed": "true", "replicator.v1.mittwald.de/replication-allowed-namespaces": "*"}} + .)' | \
    yq eval --prettyPrint - | \
    namespace="${namespace}" yq e '.metadata.namespace = env(namespace)' - > ${tmpOutputPath}/${namespace}/configmaps/${name}.yaml
    mv -f ${tmpOutputPath}/${namespace}/configmaps/${name}.yaml ${outputPath}/${namespace}/configmaps/${name}.yaml


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
    namespace="configmaps"
  fi
  configMapName=$(basename $f)
  name=$(echo "$configMapName" | cut -f 1 -d '.')

  log_debug "Generating ConfigMap: ${name}"

  mkdir -p  ${tmpOutputPath}/${namespace}/configmaps/
  mkdir -p  ${outputPath}/${namespace}/configmaps/

  cat ${f} |
    yq eval -o json - | jq '.metadata |= ({annotations: {"replicator.v1.mittwald.de/replication-allowed": "true", "replicator.v1.mittwald.de/replication-allowed-namespaces": "*"}} + .)' | \
    yq eval --prettyPrint - | \
    namespace="${namespace}" yq e '.metadata.namespace = env(namespace)' - > ${tmpOutputPath}/${namespace}/configmaps/${name}.yaml
    mv -f ${tmpOutputPath}/${namespace}/configmaps/${name}.yaml ${outputPath}/${namespace}/configmaps/${name}.yaml


done || true
fi
log_debug "Manifests Done"

rm -rf ${tmpOutputPath}

log_info "Done Building: local/configmaps/input -> local/configmaps/output..."
