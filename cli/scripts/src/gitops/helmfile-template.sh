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
check_args "$@"
## Header End
## Docs Start ##
## The main loop that templates and slices all helmfile releases
## Docs End ##

# helmfileArgs=${@:-""}
helmfileArgs=""

log_info "Templating releases..."

current_pwd=$(pwd)

configPath=${config_path}
tmpConfigPath=${tmpFolder}/config

mkdir -p ${configPath}
mkdir -p ${tmpConfigPath}

# Helmfile only is not good enough. Next line is "the old way":
# helmfile -f ${helmfilePath} ${helmfileArgs} template --skip-deps --output-dir ${configPath} --output-dir-template "{{ .OutputDir }}/{{ .Release.Namespace }}/{{ .Release.Name }}"
# TODO: Open Issue on Helmfile to explain why the latter is bad; and how the following, using kubectl slice, is better.
# Consider proposing a PR to integrate it with Helmfile.


templatingMode="all"

if [[ "${helmfileRepos}" == "yes" ]]; then
    helmfile_repos
fi
# Looping through Helmfiles
helmfiles=$(find ${helmfiles_path} -type f -name '*.helmfile.yaml.gotmpl')

log_debug "$helmfiles"

if [[ "${helmfiles}" != "" ]]; then
    while read hf; do
        log_debug "$hf"
        helmfileName=$(echo "${hf}" | xargs basename)

        if [[ "${templatingMode}" == "all" ]]; then
            log_info "Templating: ${cluster_config_name}/${helmfileName}"
            helmfilePath=${hf} helmfile_template_all "${tmpConfigPath}" "${helmfileName}"
            # helmfilePath=${hf} kubectl_slice_helmfile_templated_all "${tmpConfigPath}"
            # helmfilePath=${hf} helmfile_add_namespaces_to_all "${tmpConfigPath}"
        elif [[ "${templatingMode}" == "single" ]]; then
            # Listing all releases with Helmfile, extracting useful information
            # 1:name, 2:namespace, 3:enabled, 4:installed
            log_debug "Listing releases..."
            # inputList=$(helmfile_list | awk '{print $1" "$2" "$3" "$4}' | tail -n +2)
            inputList=$(helmfilePath=${hf} helmfile_list | awk '{print $1" "$2" "$3" "$4}' | tail -n +2)
            log_insane "${inputList}"

            log_debug "Looping through Helmfile releases - ${hf}"
            echo "${inputList}" | while read release; do

                helmfilePath=${hf} helmfile_template_release "${release}" "${tmpConfigPath}"
                # helmfilePath=${hf} helmfile_add_namespaces_to_manifests "${release}" "${tmpConfigPath}"
                # helmfilePath=${hf} kubectl_slice_helmfile_templated_release "${release}" "${tmpConfigPath}"
            done;
        fi
    done <<< "${helmfiles}"
fi
# exit 1

# get_config ${configPath} | sort -u | sed "s|${clusterConfigDirPath}|.|" > ${clusterConfigDirPath}/helmfile-config.lock
get_config ${tmpConfigPath} | sort -u | sed "s|${tmpConfigPath}|.|" > ${tmpFolder}/helmfile-config.lock

log_info "Templating done!"
