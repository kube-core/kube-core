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
corePath=$(echo ${scriptsConfigDirPath}/.. | xargs realpath)
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


log_debug "${project_name} - Minio Config Check"

mode="${1:-"remote"}"
clusterDomain="${cluster_config_domain}"

if [[ "${mode}" == "local" ]]
then
  minioHost="http://minio.minio.svc.cluster.local:80"
else
  minioHost="https://minio.minio.${baseDomain}"
fi

adminUser=$1
adminPassword=$2

amqpUser=$3
amqpPassword=$4

configString="notify_amqp:1 url=amqp://${amqpUser}:${amqpPassword}@rabbitmq.rabbitmq.svc.cluster.local:5672 exchange=${cluster_config_name}-bucket-events exchange_type=fanout routing_key=${cluster_config_name}-bucket-events mandatory=on durable=on no_wait=false internal=false auto_deleted=false delivery_mode=0 publisher_confirms=off queue_limit=0 queue_dir="

mc alias set ${cluster_config_name} ${minioHost} ${adminUser} ${adminPassword}

mc admin info "${cluster_config_name}"

amqpConfig=$(mc admin config get ${cluster_config_name} notify_amqp:1) && true

# echo $amqpConfig
# echo $configString

if [[ "$(echo -n ${amqpConfig})" == "$(echo -n ${configString})" ]]
then
  echo "Config is already set !"
else
  echo "Config is not set !"
  mc admin config set "${cluster_config_name}" "${configString}"

  mc admin service restart "${cluster_config_name}"

  mc admin info "${cluster_config_name}"
fi

echo "Reapplying buckets config..."
mc event add ${cluster_config_name}/cluster-logs arn:minio:sqs::1:amqp --event put && true
mc event add ${cluster_config_name}/app-logs arn:minio:sqs::1:amqp --event put && true


# mc admin config set my-cluster notify_amqp:1 \
#   exchange="my-cluster-bucket-events" \
#   exchange_type="fanout" \
#   mandatory="on" \
#   no_wait="false" \
#   url="amqp://${amqpUser}:${amqpPassword}@rabbitmq.rabbitmq.svc.cluster.local:5672" \
#   auto_deleted="false" \
#   delivery_mode="0" \
#   durable="on" \
#   internal="false" \
#   routing_key="my-cluster-bucket-events"

# mc admin service restart my-cluster

# mc event add my-cluster/cluster-logs arn:minio:sqs::1:amqp --event put
# mc event add my-cluster/app-logs arn:minio:sqs::1:amqp --event put