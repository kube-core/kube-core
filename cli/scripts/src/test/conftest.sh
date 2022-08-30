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


log_debug "${project_name} - Validating Policies..."

failOnError=${1:-"true"}

gitOpsConfigPath=${config_path}
testPath=${test_path}
testOutputPath=${testPath}/output

policiesPath=${test_conftest_policies_path}
conftestOutputPath=${testOutputPath}/conftest
resultsPath=${conftestOutputPath}/results

# Cleans up
rm -rf ${conftestOutputPath}
mkdir -p ${conftestOutputPath}

log_debug "conftest test ${gitOpsConfigPath} -p ${policiesPath}"

# OPA Validation
# set +e
conftest test ${gitOpsConfigPath} -p ${policiesPath}
# exit_code=$?
# set -e

# echo ${exit_code}


# if $(conftest test ${gitOpsConfigPath} -p ${policiesPath}); then
#     echo "Tests passed !"
# else
#     echo "Tests failed !"
# fi

# if [[ ${exit_code} -eq 1 ]]; then
#     echo "ERROR"
# fi

# TODO: Alternative, rework it and make it available with flags
# conftest test ${gitOpsConfigPath} -p ${policiesPath} >> ${resultsPath} || true

# cat ${resultsPath}

# if cat ${resultsPath} | grep -q "FAIL"; then
#     echo "ERROR: conftest validation failed!"
#     if [[ "${failOnError}" == "true" ]]; then
#         exit 1
#     fi
# else
#     echo "SUCCESS: conftest policies passed."
# fi

# Convert to JSONL
# cat "${resultsPath}" | jq -r 'map(tostring) | reduce .[] as $item (""; . + $item + "\n")' | grep failures > ${resultsPath}

# echo "Done validating policies !"
