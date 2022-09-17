module "gke" {
  source                  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version                 = "23.1.0"
  project_id              = var.project
  name                    = var.cluster-short-name
  region                  = var.region
  zones                   = var.zones
  network                 = module.vpc.network_name
  subnetwork              = module.vpc.subnets["${var.region}/${var.cluster-short-name}-gke"].name
  ip_range_pods           = "${var.cluster-short-name}-gke-pods"
  ip_range_services       = "${var.cluster-short-name}-gke-services"
  master_ipv4_cidr_block  = cidrsubnet(cidrsubnet(module.vpc.subnets["${var.region}/${var.cluster-short-name}-gke"].ip_cidr_range, -8, 0), 12, 512)
  enable_private_endpoint = false
  enable_private_nodes    = true
  create_service_account  = false
  service_account         = "${var.cluster-short-name}-gke@${var.project}.iam.gserviceaccount.com"

  kubernetes_version       = var.kubernetes-version
  network_policy           = false
  remove_default_node_pool = true
  node_metadata            = "UNSPECIFIED"
  monitoring_service       = "none"
  logging_service          = "none"
  enable_shielded_nodes    = false
  identity_namespace       = null

  master_authorized_networks = var.master-authorized-networks

  dns_cache = true
  enable_vertical_pod_autoscaling = true

  node_pools = [
    {
      name               = "main"
      machine_type       = "KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_MACHINE_TYPE"
      min_count          = KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_MIN_COUNT
      max_count          = KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_MAX_COUNT
      local_ssd_count    = KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_LOCAL_SSD_COUNT
      disk_size_gb       = KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_DISK_SIZE_GB
      disk_type          = "KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_DISK_TYPE"
      image_type         = "KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_IMAGE_TYPE"
      auto_repair        = KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_AUTO_REPAIR
      auto_upgrade       = KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_AUTO_UPGRADE
      preemptible        = KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_PREEMPTIBLE
      initial_node_count = KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_INITIAL_NODE_COUNT
      node_metadata      = "KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_NODE_METADATA"
      node_locations     = var.main-zone
    },
    {
      name               = "safety"
      machine_type       = "KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_MACHINE_TYPE"
      min_count          = KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_MIN_COUNT
      max_count          = KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_MAX_COUNT
      local_ssd_count    = KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_LOCAL_SSD_COUNT
      disk_size_gb       = KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_DISK_SIZE_GB
      disk_type          = "KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_DISK_TYPE"
      image_type         = "KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_IMAGE_TYPE"
      auto_repair        = KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_AUTO_REPAIR
      auto_upgrade       = KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_AUTO_UPGRADE
      preemptible        = KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_PREEMPTIBLE
      initial_node_count = KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_INITIAL_NODE_COUNT
      node_metadata      = "KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_NODE_METADATA"
      node_locations     = var.main-zone
    },
    {
      name               = "system"
      machine_type       = "KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_MACHINE_TYPE"
      min_count          = KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_MIN_COUNT
      max_count          = KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_MAX_COUNT
      local_ssd_count    = KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_LOCAL_SSD_COUNT
      disk_size_gb       = KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_DISK_SIZE_GB
      disk_type          = "KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_DISK_TYPE"
      image_type         = "KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_IMAGE_TYPE"
      auto_repair        = KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_AUTO_REPAIR
      auto_upgrade       = KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_AUTO_UPGRADE
      preemptible        = KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_PREEMPTIBLE
      initial_node_count = KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_INITIAL_NODE_COUNT
      node_metadata      = "KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_NODE_METADATA"
      node_locations     = var.main-zone
    },
    # {
    #   name               = "production"
    #   machine_type       = "KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_MACHINE_TYPE"
    #   min_count          = KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_MIN_COUNT
    #   max_count          = KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_MAX_COUNT
    #   local_ssd_count    = KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_LOCAL_SSD_COUNT
    #   disk_size_gb       = KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_DISK_SIZE_GB
    #   disk_type          = "KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_DISK_TYPE"
    #   image_type         = "KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_IMAGE_TYPE"
    #   auto_repair        = KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_AUTO_REPAIR
    #   auto_upgrade       = KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_AUTO_UPGRADE
    #   preemptible        = KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_PREEMPTIBLE
    #   initial_node_count = KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_INITIAL_NODE_COUNT
    #   node_metadata      = "KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_NODE_METADATA"
    #   node_locations     = var.main-zone
    # },
    # {
    #   name               = "monitoring"
    #   machine_type       = "KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_MACHINE_TYPE"
    #   min_count          = KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_MIN_COUNT
    #   max_count          = KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_MAX_COUNT
    #   local_ssd_count    = KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_LOCAL_SSD_COUNT
    #   disk_size_gb       = KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_DISK_SIZE_GB
    #   disk_type          = "KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_DISK_TYPE"
    #   image_type         = "KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_IMAGE_TYPE"
    #   auto_repair        = KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_AUTO_REPAIR
    #   auto_upgrade       = KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_AUTO_UPGRADE
    #   preemptible        = KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_PREEMPTIBLE
    #   initial_node_count = KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_INITIAL_NODE_COUNT
    #   node_metadata      = "KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_NODE_METADATA"
    #   node_locations     = var.main-zone
    # },
    # {
    #   name               = "logging"
    #   machine_type       = "KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_MACHINE_TYPE"
    #   min_count          = KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_MIN_COUNT
    #   max_count          = KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_MAX_COUNT
    #   local_ssd_count    = KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_LOCAL_SSD_COUNT
    #   disk_size_gb       = KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_DISK_SIZE_GB
    #   disk_type          = "KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_DISK_TYPE"
    #   image_type         = "KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_IMAGE_TYPE"
    #   auto_repair        = KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_AUTO_REPAIR
    #   auto_upgrade       = KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_AUTO_UPGRADE
    #   preemptible        = KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_PREEMPTIBLE
    #   initial_node_count = KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_INITIAL_NODE_COUNT
    #   node_metadata      = "KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_NODE_METADATA"
    #   node_locations     = var.main-zone
    # },
    # {
    #   name               = "data"
    #   machine_type       = "KUBE_CORE_CLUSTER_SPECS_NODES_DATA_MACHINE_TYPE"
    #   min_count          = KUBE_CORE_CLUSTER_SPECS_NODES_DATA_MIN_COUNT
    #   max_count          = KUBE_CORE_CLUSTER_SPECS_NODES_DATA_MAX_COUNT
    #   local_ssd_count    = KUBE_CORE_CLUSTER_SPECS_NODES_DATA_LOCAL_SSD_COUNT
    #   disk_size_gb       = KUBE_CORE_CLUSTER_SPECS_NODES_DATA_DISK_SIZE_GB
    #   disk_type          = "KUBE_CORE_CLUSTER_SPECS_NODES_DATA_DISK_TYPE"
    #   image_type         = "KUBE_CORE_CLUSTER_SPECS_NODES_DATA_IMAGE_TYPE"
    #   auto_repair        = KUBE_CORE_CLUSTER_SPECS_NODES_DATA_AUTO_REPAIR
    #   auto_upgrade       = KUBE_CORE_CLUSTER_SPECS_NODES_DATA_AUTO_UPGRADE
    #   preemptible        = KUBE_CORE_CLUSTER_SPECS_NODES_DATA_PREEMPTIBLE
    #   initial_node_count = KUBE_CORE_CLUSTER_SPECS_NODES_DATA_INITIAL_NODE_COUNT
    #   node_metadata      = "KUBE_CORE_CLUSTER_SPECS_NODES_DATA_NODE_METADATA"
    #   node_locations     = var.main-zone
    # },
    # {
    #   name               = "search"
    #   machine_type       = "KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_MACHINE_TYPE"
    #   min_count          = KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_MIN_COUNT
    #   max_count          = KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_MAX_COUNT
    #   local_ssd_count    = KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_LOCAL_SSD_COUNT
    #   disk_size_gb       = KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_DISK_SIZE_GB
    #   disk_type          = "KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_DISK_TYPE"
    #   image_type         = "KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_IMAGE_TYPE"
    #   auto_repair        = KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_AUTO_REPAIR
    #   auto_upgrade       = KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_AUTO_UPGRADE
    #   preemptible        = KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_PREEMPTIBLE
    #   initial_node_count = KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_INITIAL_NODE_COUNT
    #   node_metadata      = "KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_NODE_METADATA"
    #   node_locations     = var.main-zone
    # },
    # {
    #   name               = "web"
    #   machine_type       = "KUBE_CORE_CLUSTER_SPECS_NODES_WEB_MACHINE_TYPE"
    #   min_count          = KUBE_CORE_CLUSTER_SPECS_NODES_WEB_MIN_COUNT
    #   max_count          = KUBE_CORE_CLUSTER_SPECS_NODES_WEB_MAX_COUNT
    #   local_ssd_count    = KUBE_CORE_CLUSTER_SPECS_NODES_WEB_LOCAL_SSD_COUNT
    #   disk_size_gb       = KUBE_CORE_CLUSTER_SPECS_NODES_WEB_DISK_SIZE_GB
    #   disk_type          = "KUBE_CORE_CLUSTER_SPECS_NODES_WEB_DISK_TYPE"
    #   image_type         = "KUBE_CORE_CLUSTER_SPECS_NODES_WEB_IMAGE_TYPE"
    #   auto_repair        = KUBE_CORE_CLUSTER_SPECS_NODES_WEB_AUTO_REPAIR
    #   auto_upgrade       = KUBE_CORE_CLUSTER_SPECS_NODES_WEB_AUTO_UPGRADE
    #   preemptible        = KUBE_CORE_CLUSTER_SPECS_NODES_WEB_PREEMPTIBLE
    #   initial_node_count = KUBE_CORE_CLUSTER_SPECS_NODES_WEB_INITIAL_NODE_COUNT
    #   node_metadata      = "KUBE_CORE_CLUSTER_SPECS_NODES_WEB_NODE_METADATA"
    #   node_locations     = var.main-zone
    # },
    # {
    #   name               = "batch"
    #   machine_type       = "KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_MACHINE_TYPE"
    #   min_count          = KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_MIN_COUNT
    #   max_count          = KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_MAX_COUNT
    #   local_ssd_count    = KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_LOCAL_SSD_COUNT
    #   disk_size_gb       = KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_DISK_SIZE_GB
    #   disk_type          = "KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_DISK_TYPE"
    #   image_type         = "KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_IMAGE_TYPE"
    #   auto_repair        = KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_AUTO_REPAIR
    #   auto_upgrade       = KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_AUTO_UPGRADE
    #   preemptible        = KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_PREEMPTIBLE
    #   initial_node_count = KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_INITIAL_NODE_COUNT
    #   node_metadata      = "KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_NODE_METADATA"
    #   node_locations     = var.main-zone
    # },
    # {
    #   name               = "predator"
    #   machine_type       = "KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_MACHINE_TYPE"
    #   min_count          = KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_MIN_COUNT
    #   max_count          = KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_MAX_COUNT
    #   local_ssd_count    = KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_LOCAL_SSD_COUNT
    #   disk_size_gb       = KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_DISK_SIZE_GB
    #   disk_type          = "KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_DISK_TYPE"
    #   image_type         = "KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_IMAGE_TYPE"
    #   auto_repair        = KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_AUTO_REPAIR
    #   auto_upgrade       = KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_AUTO_UPGRADE
    #   preemptible        = KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_PREEMPTIBLE
    #   initial_node_count = KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_INITIAL_NODE_COUNT
    #   node_metadata      = "KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_NODE_METADATA"
    #   node_locations     = var.main-zone
    # },
    # {
    #   name               = "sf"
    #   machine_type       = "KUBE_CORE_CLUSTER_SPECS_NODES_SF_MACHINE_TYPE"
    #   min_count          = KUBE_CORE_CLUSTER_SPECS_NODES_SF_MIN_COUNT
    #   max_count          = KUBE_CORE_CLUSTER_SPECS_NODES_SF_MAX_COUNT
    #   local_ssd_count    = KUBE_CORE_CLUSTER_SPECS_NODES_SF_LOCAL_SSD_COUNT
    #   disk_size_gb       = KUBE_CORE_CLUSTER_SPECS_NODES_SF_DISK_SIZE_GB
    #   disk_type          = "KUBE_CORE_CLUSTER_SPECS_NODES_SF_DISK_TYPE"
    #   image_type         = "KUBE_CORE_CLUSTER_SPECS_NODES_SF_IMAGE_TYPE"
    #   auto_repair        = KUBE_CORE_CLUSTER_SPECS_NODES_SF_AUTO_REPAIR
    #   auto_upgrade       = KUBE_CORE_CLUSTER_SPECS_NODES_SF_AUTO_UPGRADE
    #   preemptible        = KUBE_CORE_CLUSTER_SPECS_NODES_SF_PREEMPTIBLE
    #   initial_node_count = KUBE_CORE_CLUSTER_SPECS_NODES_SF_INITIAL_NODE_COUNT
    #   node_metadata      = "KUBE_CORE_CLUSTER_SPECS_NODES_SF_NODE_METADATA"
    #   node_locations     = var.main-zone
    # },
  ]

  node_pools_tags = {
    all = []
  }

  node_pools_labels = {
    all = {}

    main = {
      "preemptible" = "KUBE_CORE_CLUSTER_SPECS_NODES_MAIN_PREEMPTIBLE"
      "type" = "main"
    }
    safety = {
      "preemptible" = "KUBE_CORE_CLUSTER_SPECS_NODES_SAFETY_PREEMPTIBLE"
      "type" = "safety"
    }
    system = {
      "preemptible" = "KUBE_CORE_CLUSTER_SPECS_NODES_SYSTEM_PREEMPTIBLE"
      "type" = "system"
    }
    # production = {
    #   "preemptible" = "KUBE_CORE_CLUSTER_SPECS_NODES_PRODUCTION_PREEMPTIBLE"
    #   "type" = "production"
    # }
    # monitoring = {
    #   "preemptible" = "KUBE_CORE_CLUSTER_SPECS_NODES_MONITORING_PREEMPTIBLE"
    #   "type" = "monitoring"
    # }
    # logging = {
    #   "preemptible" = "KUBE_CORE_CLUSTER_SPECS_NODES_LOGGING_PREEMPTIBLE"
    #   "type" = "logging"
    # }
    # data = {
    #   "preemptible" = "KUBE_CORE_CLUSTER_SPECS_NODES_DATA_PREEMPTIBLE"
    #   "type" = "data"
    # }
    # search = {
    #   "preemptible" = "KUBE_CORE_CLUSTER_SPECS_NODES_SEARCH_PREEMPTIBLE"
    #   "type" = "search"
    # }
    # web = {
    #   "preemptible" = "KUBE_CORE_CLUSTER_SPECS_NODES_WEB_PREEMPTIBLE"
    #   "type" = "web"
    # }
    # batch = {
    #   "preemptible" = "KUBE_CORE_CLUSTER_SPECS_NODES_BATCH_PREEMPTIBLE"
    #   "type" = "batch"
    # }
    # predator = {
    #   "preemptible" = "KUBE_CORE_CLUSTER_SPECS_NODES_PREDATOR_PREEMPTIBLE"
    #   "type" = "predator"
    # }
    # sf = {
    #   "preemptible" = "KUBE_CORE_CLUSTER_SPECS_NODES_SF_PREEMPTIBLE"
    #   "type" = "sf"
    # }
  }
}
