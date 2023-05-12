#!/bin/bash
set -eou pipefail

## Header Start

# Current Script
currentScript=${BASH_SOURCE[0]}
currentScriptPath="$( cd "$( dirname "${currentScript}" )" >/dev/null 2>&1 && pwd )"
currentScriptShortPath=$(echo "${currentScriptPath}" | awk '{split($0, a, "/scripts/"); print a[2]}')

# Cluster Config
if [[  $(find ./cluster-config.yaml 2> /dev/null) != "" ]]; then
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
if [[  $(find ${currentScriptPath}/scripts-config.yaml 2> /dev/null) != "" ]]; then
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
## Gets all helmfile env values. Wrapped by: kube-core values all
## Docs End ##

mode=${1:-"all"}
deepFilterKeys=${2:-"cluster|environments|releases"}
selectedDimensions=${3:-"cloud|config|customExtensions|dynamicSecrets|external-secrets|extraReleaseValues|hooks|ingress|jsonPatches|labels|manifests|monitoring|options|patches|scaling|scheduling|secrets|slack|slos|strategicMergePatches|values"}


valuesTmpPath=${tmpFolder}/values
valuesPath=${values_path}
reshapedPath=$(echo ${valuesTmpPath}/reshaped)
rm -rf ${valuesTmpPath}
mkdir -p ${valuesTmpPath}
rm -rf ${reshapedPath}
mkdir -p ${reshapedPath}
mkdir -p ${valuesPath}

find ${valuesPath} -type f -name '*.yaml' | xargs yq ea '. as $item ireduce ({}; . * $item )' > "${valuesTmpPath}/all.yaml"

data=$(cat "${valuesTmpPath}/all.yaml")

if [[ "$mode" == "all" ]]; then
  filePath=$(echo $reshapedPath/all).yaml
  echo "$data" | yq 'sort_keys(..)' -P > ${filePath}
elif [[ "$mode" == "keys" ]]; then
  keys=$(echo "$data" | yq -o j | jq '. | keys[]' -r)
  while read key; do
    filePath=$(echo ${reshapedPath}/${key}).yaml
    echo "$data" | key=$key yq '{env(key): .[env(key)]}' | yq 'sort_keys(..)' -P > ${filePath}
  done <<< $keys
elif [[ "$mode" == "deep" ]]; then
  keys=$(echo "$data" | yq -o j | jq '. | keys[]' -r)
  # echo "$keys"
  while read key; do
    filePath=$(echo ${reshapedPath}/${key}).yaml
    if echo $key | grep -qEw ${deepFilterKeys} ; then
      subKeys=$(echo "$data" | key=$key yq '.[env(key)]' | yq -o j | jq '. | keys[]' -r)
      subFolder=$(echo ${reshapedPath}/${key})
      mkdir -p $subFolder
      # echo "$subKeys"
      while read subKey; do
        # echo $subKey
        subPath=$(echo ${subFolder}/${subKey}).yaml
        echo "$data" | key=$key subKey=$subKey yq '{env(key): {env(subKey): .[env(key)][env(subKey)]}}' | yq 'sort_keys(..)' > ${subPath}
      done <<< $subKeys
    else
      echo "$data" | key=$key yq '{env(key): .[env(key)]}' | yq 'sort_keys(..)' -P > ${filePath}
    fi
  done <<< $keys
elif [[ "$mode" == "releases" ]]; then
  keys=$(echo "$data" | yq -o j | jq '. | keys[]' -r)
  # echo "$keys"
  while read key; do
    filePath=$(echo ${reshapedPath}/${key}).yaml
    if echo $key | grep -vqw "releases" ; then
      if echo $key | grep -qEw ${deepFilterKeys} ; then
        subKeys=$(echo "$data" | key=$key yq '.[env(key)]' | yq -o j | jq '. | keys[]' -r)
        subFolder=$(echo ${reshapedPath}/${key})
        mkdir -p $subFolder
        # echo "$subKeys"
        while read subKey; do
          # echo $subKey
          subPath=$(echo ${subFolder}/${subKey}).yaml
          echo "$data" | key=$key subKey=$subKey yq '{env(key): {env(subKey): .[env(key)][env(subKey)]}}' | yq 'sort_keys(..)' > ${subPath}
        done <<< $subKeys
      else
        echo "$data" | key=$key yq '{env(key): .[env(key)]}' | yq 'sort_keys(..)' -P > ${filePath}
      fi
    fi
  done <<< $keys
  dimensions=$(cat .kube-core/.tmp/values/all.yaml | yq '.releases[] | keys | .[]' | sort -u)
  while read dimension; do
    if echo $dimension | grep -qEw ${selectedDimensions} ; then
      folder=$(echo $reshapedPath/releases)
      mkdir -p $folder
      filePath=$(echo $folder/releases)
      filePath=$(echo "$filePath-$dimension").yaml
      echo "$data" | dimension=$dimension yq '.releases | to_entries | .[] | select(.value[env(dimension)]) | {.key: {env(dimension): .value[env(dimension)]}}' | yq '{"releases":.}' | yq 'del(.. | select(tag == "!!map" and length == 0))' | yq 'del(.. | select(tag == "!!map" and length == 0))'  | yq 'sort_keys(..)' -P > $filePath
    else
      folder=$(echo $reshapedPath/releases)
      mkdir -p $folder
      filePath=$(echo $folder/releases)
      filePath=$(echo "$filePath-schema").yaml
      # echo $dimension
      # echo $filePath
      dimensionData=$(echo "$data" | dimension=$dimension yq '.releases | to_entries | .[] | select(.value[env(dimension)]) | {.key: {env(dimension): .value[env(dimension)]}}' | yq '{"releases":.}' | yq 'del(.. | select(tag == "!!map" and length == 0))' | yq 'del(.. | select(tag == "!!map" and length == 0))'  | yq 'sort_keys(..)')
      if [[ ! -f $filePath ]]; then
        if [[  $dimensionData != "" ]]; then
          # echo "File not created"
          echo "$dimensionData" > $filePath
        fi
      else
        # echo "File exists"
        echo "$dimensionData" | filePath=$filePath yq '. *= load(env(filePath))' > ${filePath}_tmp
        mv -f ${filePath}_tmp ${filePath}
        rm -rf ${filePath}_tmp
      fi
    fi
  done <<< $dimensions
elif [[ "$mode" == "environments" ]]; then
  keys=$(echo "$data" | yq -o j | jq '. | keys[]' -r)
  # echo "$keys"
  while read key; do
    folderPath=$(echo "${reshapedPath}/core")
    mkdir -p $folderPath
    filePath=$(echo $folderPath/${key}).yaml
    if echo $key | grep -vqEw "releases|environments" ; then
      if echo $key | grep -qEw ${deepFilterKeys} ; then
        subKeys=$(echo "$data" | key=$key yq '.[env(key)]' | yq -o j | jq '. | keys[]' -r)
        subFolder=$(echo ${reshapedPath}/${key})
        mkdir -p $subFolder
        # echo "$subKeys"
        while read subKey; do
          # echo $subKey
          subPath=$(echo ${subFolder}/${subKey}).yaml
          echo "$data" | key=$key subKey=$subKey yq '{env(key): {env(subKey): .[env(key)][env(subKey)]}}' | yq 'sort_keys(..)' > ${subPath}
        done <<< $subKeys
      else
        echo "$data" | key=$key yq '{env(key): .[env(key)]}' | yq 'sort_keys(..)' -P > ${filePath}
      fi
    fi
  done <<< $keys
  dimensions=$(cat .kube-core/.tmp/values/all.yaml | yq '.releases[] | keys | .[]' | sort -u)
  while read dimension; do
    if echo $dimension | grep -qEw ${selectedDimensions} ; then
      folder=$(echo $reshapedPath/releases)
      mkdir -p $folder
      filePath=$(echo $folder/releases)
      filePath=$(echo "$filePath-$dimension").yaml
      dimensionData=$(echo "$data" | dimension=$dimension yq '.releases | to_entries | .[] | select(.value[env(dimension)]) | {.key: {env(dimension): .value[env(dimension)]}}' | yq '{"releases":.}' | yq 'del(.. | select(tag == "!!map" and length == 0))' | yq 'del(.. | select(tag == "!!map" and length == 0))'  | yq 'sort_keys(..)' -P)
      if [[  $dimensionData != "" ]]; then
        echo "$dimensionData" > $filePath
      fi > $filePath
    else
      folder=$(echo $reshapedPath/releases)
      mkdir -p $folder
      filePath=$(echo $folder/releases)
      filePath=$(echo "$filePath-schema").yaml
      dimensionData=$(echo "$data" | dimension=$dimension yq '.releases | to_entries | .[] | select(.value[env(dimension)]) | {.key: {env(dimension): .value[env(dimension)]}}' | yq '{"releases":.}' | yq 'del(.. | select(tag == "!!map" and length == 0))' | yq 'del(.. | select(tag == "!!map" and length == 0))'  | yq 'sort_keys(..)')
      if [[ ! -f $filePath ]]; then
        if [[  $dimensionData != "" ]]; then
          # echo "File not created"
          echo "$dimensionData" > $filePath
        fi
      else
        # echo "File exists"
        echo "$dimensionData" | filePath=$filePath yq '. *= load(env(filePath))' > ${filePath}_tmp
        mv -f ${filePath}_tmp ${filePath}
        rm -rf ${filePath}_tmp
      fi
    fi
  done <<< $dimensions

  environments=$(cat .kube-core/.tmp/values/all.yaml | yq '.environments | keys | .[]' | sort -u)
  dimensions=$(cat .kube-core/.tmp/values/all.yaml | yq '.environments[] | keys | .[]' | sort -u)
  while read environment; do
    while read dimension; do
      selectedDimensions="applications|services|applicationsConfig|servicesConfig"
      if echo $dimension | grep -qEw ${selectedDimensions} ; then
        folder=$(echo $reshapedPath)
        filePath=$(echo $folder/environments)
        mkdir -p "$filePath/$environment"
        filePath=$(echo "$filePath/$environment/$dimension").yaml
        processedData=""
        dimensionData=$(echo "$data" | dimension=$dimension environment=$environment yq '.environments | to_entries | .[] | select(.key==env(environment)) | select(.value[env(dimension)]) | {.key: {env(dimension): .value[env(dimension)]}}')
        if [[  "$dimensionData" != "" ]]; then
          processedData=$(echo "$dimensionData" | yq '{"environments":.}' | yq 'del(.. | select(tag == "!!map" and length == 0))' | yq 'del(.. | select(tag == "!!map" and length == 0))'  | yq 'sort_keys(..)' -P)
        fi
        if [[  $processedData != "" ]]; then
          echo "$processedData" > $filePath
        fi > $filePath
      else
        folder=$(echo $reshapedPath)
        filePath=$(echo $folder/environments)
        mkdir -p "$filePath/$environment"
        filePath=$(echo "$filePath/$environment/schema").yaml
        # echo $dimension
        # echo $filePath
        processedData=""
        dimensionData=$(echo "$data" | dimension=$dimension environment=$environment yq '.environments | to_entries | .[] | select(.key==env(environment)) | select(.value[env(dimension)]) | {.key: {env(dimension): .value[env(dimension)]}}')
        if [[  "$dimensionData" != "" ]]; then
          processedData=$(echo "$dimensionData" | yq '{"environments":.}' | yq 'del(.. | select(tag == "!!map" and length == 0))' | yq 'del(.. | select(tag == "!!map" and length == 0))'  | yq 'sort_keys(..)' -P)
        fi
        if [[ ! -f $filePath ]]; then
          if [[  $processedData != "" ]]; then
            # echo "File not created"
            echo "$processedData" > $filePath
          fi
        else
          # echo "File exists"
          if [[  $processedData != "" ]]; then
            echo "$dimensionData" | filePath=$filePath yq '. *= load(env(filePath))' > ${filePath}_tmp
            mv -f ${filePath}_tmp ${filePath}
            rm -rf ${filePath}_tmp
            fi
        fi
      fi
    done <<< "$dimensions"
  done <<< "$environments"

elif [[ "$mode" == "custom" ]]; then
  echo "${data}"
fi

rm -rf ${valuesPath}
mv ${reshapedPath} ${valuesPath}

# if [[ "$OSTYPE" == "msys" ]]; then
#   cat ${values_path}/all.yaml | yq '. | to_entries' | yq '.[]' -s '"'"${values_path:2}"'/" + .key'
# else
#   cat ${values_path}/all.yaml | yq '. | to_entries' | yq '.[]' -s '"'"${values_path}"'/" + .key'
# fi
