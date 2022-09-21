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
# if [[ -z "${clusterConfigPath}" ]] ; then
#     echo "Stopping ${currentScript}"
#     echo "This script requires to be in a cluster context, but cluster-config.yaml not found in parent directories"
#     exit 0
# fi

# clusterConfigDirPath=$(dirname ${clusterConfigPath} | xargs realpath)
# helmfilePath="${clusterConfigDirPath}/helmfile.yaml"
# tmpFolder="${clusterConfigDirPath}/.kube-core/.tmp"

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
# clusterConfigVars=$(parse_yaml ${defaultClusterConfigPath})
# clusterConfigVars=$(echo "${clusterConfigVars}" | sed "s|\./|${clusterConfigDirPath}/|")
# eval "${clusterConfigVars}"

# # Loading cluster-config.yaml
# clusterConfigVars=$(parse_yaml ${clusterConfigPath})
# clusterConfigVars=$(echo "${clusterConfigVars}" | sed "s|\./|${clusterConfigDirPath}/|")
# eval "${clusterConfigVars}"

# Loading scripts-config.yaml
# paths=$(parse_yaml ${scriptsConfigPath})
# absolutePaths=$(echo "${paths}" | sed "s|\./|${scriptsConfigDirPath}/|")
# eval "${absolutePaths}"

check_requirements
# check_context "${cluster_config_context}"
# check_args "$@"
## Docs Start ##
## Generates scripts-config.yaml
## Docs End ##

log_info "Generating scripts-config..."

scriptsList=$(find ${scriptsConfigDirPath}/src/ ${scriptsConfigDirPath}/commands/ -type f -name '*.sh' )

jsonScriptsConfig=""
while read scriptPath; do
    log_debug ${scriptPath}
    if [[ ${scriptPath} != $(realpath ${currentScript}) ]]; then
        docs=$(cat ${scriptPath} | sed -n '/## Docs Start ##/,/## Docs End ##/p')
        strippedDocs=""
        if [[ ! -z ${docs} ]]; then
            strippedDocs=$(echo "${docs}" | grep -v '## Docs Start ##' | grep -v '## Docs End ##')
        fi

        log_debug ${scriptPath}
        log_debug ${strippedDocs}
        scriptPath=$(echo ${scriptPath} | sed "s|${scriptsConfigDirPath}||")
        scriptName=$(echo ${scriptPath} | sed 's|/src/||' | sed 's|/commands/||' |  sed 's|-|_|g' | sed 's|/|_|g' | sed 's|\.sh||')
    else
        scriptPath=$(echo ${currentScript} | sed "s|${scriptsConfigDirPath}||")
        scriptName="utils_generate_scripts_config"
        strippedDocs="Generates scripts-config.yaml"
    fi
        args=""
        if echo $strippedDocs | grep -q Args ; then
            args=$(echo "${strippedDocs}" | sed 's/.*\(Args: .*\)/\1/' )
            ESCAPED_REPLACE=$(printf '%s\n' "$args" | sed -e 's/[\/&]/\\&/g')
            strippedDocs=$(echo "${strippedDocs}" | sed "s/${ESCAPED_REPLACE}//")
        fi
        strippedDocs=$(echo "${strippedDocs}" | sed "s/## //")
        args=$(echo "${args}" | sed "s/Args: //")
        jsonScriptConfig=$(jq -R -n '{path: "'".${scriptPath}"'", name: "'"${scriptName}"'", description:"'"${strippedDocs}"'", args: "'"${args}"'"}')
        echo "${jsonScriptConfig}" | jq -c
        # exit
done <<< "${scriptsList}" | jq -s | jq '.[] | {(.name): .}' | jq -s '{scripts: (add)}' | yq e - -P > ${scriptsConfigPath}

log_info "Done generating scripts-config!"



# | jq -R '{path: ., name:"", description:"", args: ""}' | jq -s | jq '.[] | {(.path): .}' | jq -s '{scripts: (add)}' | yq e - -P | clipboard
