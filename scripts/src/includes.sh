#!/bin/bash
set -eou pipefail

## Header Start

# Current Script
currentScript=${BASH_SOURCE[0]}
currentScriptPath="$( cd "$( dirname "${currentScript}" )" >/dev/null 2>&1 && pwd )"
currentScriptShortPath=$(echo "${currentScriptPath}" | awk '{split($0, a, "/scripts/"); print a[2]}')

# Cluster Config
# clusterConfigPath=$(eval find ./$(printf "{$(echo %{1..7}q,)}" | sed 's/ /\.\.\//g') -maxdepth 1 -name cluster-config.yaml | head -n 1 | xargs realpath)
# clusterConfigDirPath=$(dirname ${clusterConfigPath} | xargs realpath)
# helmfilePath="${clusterConfigDirPath}/helmfile.yaml"

# Cluster Scripts
if [[ ! -z $(find ${currentScriptPath}/scripts-config.yaml 2> /dev/null) ]]; then
    scriptsConfigPath=$(echo ${currentScriptPath}/scripts-config.yaml | head -n 1 | xargs realpath 2> /dev/null)
else
    scriptsConfigPath=$(eval find "${currentScriptPath}"/$(printf "{$(echo %{1..7}q,)}" | sed 's/ /\.\.\//g') -maxdepth 1 -name scripts-config.yaml | head -n 1 | xargs realpath)
fi
scriptsConfigDirPath=$(dirname ${scriptsConfigPath} | xargs realpath)

echo "source ${scriptsConfigDirPath}/src/utils/yaml/parse_yaml.sh"
echo "source ${scriptsConfigDirPath}/src/utils/yaml/get_config.sh"
echo "source ${scriptsConfigDirPath}/src/utils/yaml/log.sh"
echo "source ${scriptsConfigDirPath}/src/k8s/check-context.sh"
echo "source ${scriptsConfigDirPath}/src/gitops/utils/check-requirements.sh"
echo "source ${scriptsConfigDirPath}/src/utils/argparse.bash.sh"
echo "source ${scriptsConfigDirPath}/src/lib/apply/crds.sh"
echo "source ${scriptsConfigDirPath}/src/lib/apply/config.sh"
echo "source ${scriptsConfigDirPath}/src/lib/apply/namespaces.sh"
echo "source ${scriptsConfigDirPath}/src/lib/apply/helmfile.sh"
echo "source ${scriptsConfigDirPath}/src/lib/apply/kubectl.sh"

# ENV
export HELM_DIFF_IGNORE_UNKNOWN_FLAGS=true
export HELM_DIFF_COLOR=true
export HELM_DIFF_NORMALIZE_MANIFESTS=true
# export HELM_DIFF_USE_UPGRADE_DRY_RUN=true # TODO: Check if we use this
# export HELM_DIFF_THREE_WAY_MERGE=true # TODO: Check if we use this