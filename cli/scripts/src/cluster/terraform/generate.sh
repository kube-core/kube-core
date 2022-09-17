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


log_info "cluster_terraform_generate - Start"

# Do something here!


tfTemplates=$(find ${currentScriptPath}/templates/cluster -type f -name '*.tf')

if [[ ! -z ${tfTemplates} ]]; then
    targetPath=${clusterConfigDirPath}/terraform/${cluster_config_shortName}
    mkdir -p ${targetPath}
    while read template; do
        cat "$template" | sed \
            -e "s/KUBE_CORE_CLUSTER_CONFIG_SHORT_NAME/${cluster_config_shortName}/g" \
            -e "s/KUBE_CORE_CLUSTER_CONFIG_NAME/${cluster_config_name}/g" \
            -e "s/KUBE_CORE_CLUSTER_CONFIG_ADMIN_EMAIL/${cluster_config_adminEmail}/g" \
            -e "s/KUBE_CORE_CLOUD_PROJECT/${cloud_project}/g" \
            -e "s/KUBE_CORE_CLOUD_DEFAULT_LOCATION/${cloud_default_location}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_AUTOSCALING_PROFILE/${cluster_specs_autoscaling_profile}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_MACHINE_TYPE/${cluster_specs_nodes_main_machine_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_MIN_COUNT/${cluster_specs_nodes_main_min_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_MAX_COUNT/${cluster_specs_nodes_main_max_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_LOCAL_SSD_COUNT/${cluster_specs_nodes_main_local_ssd_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_DISK_SIZE_GB/${cluster_specs_nodes_main_disk_size_gb}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_DISK_TYPE/${cluster_specs_nodes_main_disk_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_IMAGE_TYPE/${cluster_specs_nodes_main_image_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_AUTO_REPAIR/${cluster_specs_nodes_main_auto_repair}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_AUTO_UPGRADE/${cluster_specs_nodes_main_auto_upgrade}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_PREEMPTIBLE/${cluster_specs_nodes_main_preemptible}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_INITIAL_NODE_COUNT/${cluster_specs_nodes_main_initial_node_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_NODE_METADATA/${cluster_specs_nodes_main_node_metadata}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_MACHINE_TYPE/${cluster_specs_nodes_safety_machine_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_MIN_COUNT/${cluster_specs_nodes_safety_min_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_MAX_COUNT/${cluster_specs_nodes_safety_max_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_LOCAL_SSD_COUNT/${cluster_specs_nodes_safety_local_ssd_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_DISK_SIZE_GB/${cluster_specs_nodes_safety_disk_size_gb}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_DISK_TYPE/${cluster_specs_nodes_safety_disk_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_IMAGE_TYPE/${cluster_specs_nodes_safety_image_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_AUTO_REPAIR/${cluster_specs_nodes_safety_auto_repair}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_AUTO_UPGRADE/${cluster_specs_nodes_safety_auto_upgrade}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_PREEMPTIBLE/${cluster_specs_nodes_safety_preemptible}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_INITIAL_NODE_COUNT/${cluster_specs_nodes_safety_initial_node_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_NODE_METADATA/${cluster_specs_nodes_safety_node_metadata}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_MACHINE_TYPE/${cluster_specs_nodes_system_machine_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_MIN_COUNT/${cluster_specs_nodes_system_min_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_MAX_COUNT/${cluster_specs_nodes_system_max_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_LOCAL_SSD_COUNT/${cluster_specs_nodes_system_local_ssd_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_DISK_SIZE_GB/${cluster_specs_nodes_system_disk_size_gb}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_DISK_TYPE/${cluster_specs_nodes_system_disk_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_IMAGE_TYPE/${cluster_specs_nodes_system_image_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_AUTO_REPAIR/${cluster_specs_nodes_system_auto_repair}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_AUTO_UPGRADE/${cluster_specs_nodes_system_auto_upgrade}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_PREEMPTIBLE/${cluster_specs_nodes_system_preemptible}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_INITIAL_NODE_COUNT/${cluster_specs_nodes_system_initial_node_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_NODE_METADATA/${cluster_specs_nodes_system_node_metadata}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_MACHINE_TYPE/${cluster_specs_nodes_production_machine_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_MIN_COUNT/${cluster_specs_nodes_production_min_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_MAX_COUNT/${cluster_specs_nodes_production_max_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_LOCAL_SSD_COUNT/${cluster_specs_nodes_production_local_ssd_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_DISK_SIZE_GB/${cluster_specs_nodes_production_disk_size_gb}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_DISK_TYPE/${cluster_specs_nodes_production_disk_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_IMAGE_TYPE/${cluster_specs_nodes_production_image_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_AUTO_REPAIR/${cluster_specs_nodes_production_auto_repair}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_AUTO_UPGRADE/${cluster_specs_nodes_production_auto_upgrade}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_PREEMPTIBLE/${cluster_specs_nodes_production_preemptible}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_INITIAL_NODE_COUNT/${cluster_specs_nodes_production_initial_node_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_NODE_METADATA/${cluster_specs_nodes_production_node_metadata}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_MACHINE_TYPE/${cluster_specs_nodes_monitoring_machine_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_MIN_COUNT/${cluster_specs_nodes_monitoring_min_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_MAX_COUNT/${cluster_specs_nodes_monitoring_max_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_LOCAL_SSD_COUNT/${cluster_specs_nodes_monitoring_local_ssd_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_DISK_SIZE_GB/${cluster_specs_nodes_monitoring_disk_size_gb}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_DISK_TYPE/${cluster_specs_nodes_monitoring_disk_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_IMAGE_TYPE/${cluster_specs_nodes_monitoring_image_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_AUTO_REPAIR/${cluster_specs_nodes_monitoring_auto_repair}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_AUTO_UPGRADE/${cluster_specs_nodes_monitoring_auto_upgrade}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_PREEMPTIBLE/${cluster_specs_nodes_monitoring_preemptible}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_INITIAL_NODE_COUNT/${cluster_specs_nodes_monitoring_initial_node_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_NODE_METADATA/${cluster_specs_nodes_monitoring_node_metadata}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_MACHINE_TYPE/${cluster_specs_nodes_logging_machine_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_MIN_COUNT/${cluster_specs_nodes_logging_min_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_MAX_COUNT/${cluster_specs_nodes_logging_max_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_LOCAL_SSD_COUNT/${cluster_specs_nodes_logging_local_ssd_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_DISK_SIZE_GB/${cluster_specs_nodes_logging_disk_size_gb}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_DISK_TYPE/${cluster_specs_nodes_logging_disk_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_IMAGE_TYPE/${cluster_specs_nodes_logging_image_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_AUTO_REPAIR/${cluster_specs_nodes_logging_auto_repair}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_AUTO_UPGRADE/${cluster_specs_nodes_logging_auto_upgrade}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_PREEMPTIBLE/${cluster_specs_nodes_logging_preemptible}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_INITIAL_NODE_COUNT/${cluster_specs_nodes_logging_initial_node_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_NODE_METADATA/${cluster_specs_nodes_logging_node_metadata}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_DATA_MACHINE_TYPE/${cluster_specs_nodes_data_machine_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_DATA_MIN_COUNT/${cluster_specs_nodes_data_min_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_DATA_MAX_COUNT/${cluster_specs_nodes_data_max_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_DATA_LOCAL_SSD_COUNT/${cluster_specs_nodes_data_local_ssd_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_DATA_DISK_SIZE_GB/${cluster_specs_nodes_data_disk_size_gb}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_DATA_DISK_TYPE/${cluster_specs_nodes_data_disk_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_DATA_IMAGE_TYPE/${cluster_specs_nodes_data_image_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_DATA_AUTO_REPAIR/${cluster_specs_nodes_data_auto_repair}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_DATA_AUTO_UPGRADE/${cluster_specs_nodes_data_auto_upgrade}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_DATA_PREEMPTIBLE/${cluster_specs_nodes_data_preemptible}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_DATA_INITIAL_NODE_COUNT/${cluster_specs_nodes_data_initial_node_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_DATA_NODE_METADATA/${cluster_specs_nodes_data_node_metadata}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_MACHINE_TYPE/${cluster_specs_nodes_search_machine_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_MIN_COUNT/${cluster_specs_nodes_search_min_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_MAX_COUNT/${cluster_specs_nodes_search_max_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_LOCAL_SSD_COUNT/${cluster_specs_nodes_search_local_ssd_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_DISK_SIZE_GB/${cluster_specs_nodes_search_disk_size_gb}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_DISK_TYPE/${cluster_specs_nodes_search_disk_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_IMAGE_TYPE/${cluster_specs_nodes_search_image_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_AUTO_REPAIR/${cluster_specs_nodes_search_auto_repair}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_AUTO_UPGRADE/${cluster_specs_nodes_search_auto_upgrade}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_PREEMPTIBLE/${cluster_specs_nodes_search_preemptible}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_INITIAL_NODE_COUNT/${cluster_specs_nodes_search_initial_node_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_NODE_METADATA/${cluster_specs_nodes_search_node_metadata}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_WEB_MACHINE_TYPE/${cluster_specs_nodes_web_machine_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_WEB_MIN_COUNT/${cluster_specs_nodes_web_min_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_WEB_MAX_COUNT/${cluster_specs_nodes_web_max_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_WEB_LOCAL_SSD_COUNT/${cluster_specs_nodes_web_local_ssd_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_WEB_DISK_SIZE_GB/${cluster_specs_nodes_web_disk_size_gb}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_WEB_DISK_TYPE/${cluster_specs_nodes_web_disk_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_WEB_IMAGE_TYPE/${cluster_specs_nodes_web_image_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_WEB_AUTO_REPAIR/${cluster_specs_nodes_web_auto_repair}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_WEB_AUTO_UPGRADE/${cluster_specs_nodes_web_auto_upgrade}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_WEB_PREEMPTIBLE/${cluster_specs_nodes_web_preemptible}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_WEB_INITIAL_NODE_COUNT/${cluster_specs_nodes_web_initial_node_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_WEB_NODE_METADATA/${cluster_specs_nodes_web_node_metadata}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_MACHINE_TYPE/${cluster_specs_nodes_batch_machine_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_MIN_COUNT/${cluster_specs_nodes_batch_min_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_MAX_COUNT/${cluster_specs_nodes_batch_max_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_LOCAL_SSD_COUNT/${cluster_specs_nodes_batch_local_ssd_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_DISK_SIZE_GB/${cluster_specs_nodes_batch_disk_size_gb}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_DISK_TYPE/${cluster_specs_nodes_batch_disk_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_IMAGE_TYPE/${cluster_specs_nodes_batch_image_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_AUTO_REPAIR/${cluster_specs_nodes_batch_auto_repair}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_AUTO_UPGRADE/${cluster_specs_nodes_batch_auto_upgrade}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_PREEMPTIBLE/${cluster_specs_nodes_batch_preemptible}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_INITIAL_NODE_COUNT/${cluster_specs_nodes_batch_initial_node_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_NODE_METADATA/${cluster_specs_nodes_batch_node_metadata}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_MACHINE_TYPE/${cluster_specs_nodes_predator_machine_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_MIN_COUNT/${cluster_specs_nodes_predator_min_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_MAX_COUNT/${cluster_specs_nodes_predator_max_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_LOCAL_SSD_COUNT/${cluster_specs_nodes_predator_local_ssd_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_DISK_SIZE_GB/${cluster_specs_nodes_predator_disk_size_gb}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_DISK_TYPE/${cluster_specs_nodes_predator_disk_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_IMAGE_TYPE/${cluster_specs_nodes_predator_image_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_AUTO_REPAIR/${cluster_specs_nodes_predator_auto_repair}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_AUTO_UPGRADE/${cluster_specs_nodes_predator_auto_upgrade}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_PREEMPTIBLE/${cluster_specs_nodes_predator_preemptible}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_INITIAL_NODE_COUNT/${cluster_specs_nodes_predator_initial_node_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_NODE_METADATA/${cluster_specs_nodes_predator_node_metadata}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SF_MACHINE_TYPE/${cluster_specs_nodes_sf_machine_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SF_MIN_COUNT/${cluster_specs_nodes_sf_min_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SF_MAX_COUNT/${cluster_specs_nodes_sf_max_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SF_LOCAL_SSD_COUNT/${cluster_specs_nodes_sf_local_ssd_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SF_DISK_SIZE_GB/${cluster_specs_nodes_sf_disk_size_gb}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SF_DISK_TYPE/${cluster_specs_nodes_sf_disk_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SF_IMAGE_TYPE/${cluster_specs_nodes_sf_image_type}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SF_AUTO_REPAIR/${cluster_specs_nodes_sf_auto_repair}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SF_AUTO_UPGRADE/${cluster_specs_nodes_sf_auto_upgrade}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SF_PREEMPTIBLE/${cluster_specs_nodes_sf_preemptible}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SF_INITIAL_NODE_COUNT/${cluster_specs_nodes_sf_initial_node_count}/g" \
            -e "s/KUBE_CORE_CLUSTER_SPECS_NODES_SF_NODE_METADATA/${cluster_specs_nodes_sf_node_metadata}/g" \
        > ${targetPath}/$(basename $template)
    done <<< "${tfTemplates}"
fi

log_info "cluster_terraform_generate - End"
