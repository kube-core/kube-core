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

# # Loading default-cluster-config.yaml
# clusterConfigVars=$(parse_yaml ${defaultClusterConfigPath})
# clusterConfigVars=$(echo "${clusterConfigVars}" | sed "s|\./|${clusterConfigDirPath}/|")
# eval "${clusterConfigVars}"

# # Loading cluster-config.yaml
# clusterConfigVars=$(parse_yaml ${clusterConfigPath})
# clusterConfigVars=$(echo "${clusterConfigVars}" | sed "s|\./|${clusterConfigDirPath}/|")
# eval "${clusterConfigVars}"

# Loading scripts-config.yaml
paths=$(parse_yaml ${scriptsConfigPath})
absolutePaths=$(echo "${paths}" | sed "s|\./|${scriptsConfigDirPath}/|")
eval "${absolutePaths}"

check_requirements
# check_context "${cluster_config_context}"
# check_args "$@"
## Header End
## Docs Start ##
## For kube-core releases development. Updates all vendir-releases entries to latest versions.
## Docs End ##

vendirReleases=${corePath}/vendir-releases.yaml

# cat vendir-releases.yaml | yq '.directories[].contents[] | select(.helmChart.repository.url=="https://kube-core.github.io/helm-charts") | [.]'

filter=${1:-""}


cat ${vendirReleases} | yq '.directories[].contents[] | [{"name": .path, "repository": .helmChart.repository.url, "version": .helmChart.version }]' -o json | jq '.[]' | jq -c '[.name, .repository, .version] | @tsv' -r | while read repo url version; do
  echo "Updating chart $repo from repository $url ..."
  helm repo add $repo $url > /dev/null
  helm repo update $repo  > /dev/null
  newVersion=$(helm search repo ${repo}/${repo} -o json | jq -r '.[0].version')
  echo "Current version:" $version
  echo "Latest version:" $newVersion
  if [[ ! -z "${filter}" ]]; then
    if echo $repo | grep -q $filter; then
      yq -i '.directories[].contents |= map(select(.helmChart.name == "'"${repo}"'").helmChart.version="'"${newVersion}"'")' ${vendirReleases}
      echo "Done updating chart $repo from repository $url"
    fi
  else
    yq -i '.directories[].contents |= map(select(.helmChart.name == "'"${repo}"'").helmChart.version="'"${newVersion}"'")' ${vendirReleases}
    echo "Done updating chart $repo from repository $url"
  fi
done

echo "Done, releases are updated!"
