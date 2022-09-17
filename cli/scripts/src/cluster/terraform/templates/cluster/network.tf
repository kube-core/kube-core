module "vpc" {
  source       = "terraform-google-modules/network/google"
  # version      = "~> 3.0"

  project_id   = var.project
  network_name = var.cluster-short-name
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "${var.cluster-short-name}-gke"
      subnet_ip     = var.vpc-subnet-range
      subnet_region = var.region
    }
  ]

  secondary_ranges = {
    "${var.cluster-short-name}-gke" = [
      {
        range_name    = "${var.cluster-short-name}-gke-pods"
        ip_cidr_range = var.vpc-pods-range
      },
      {
        range_name    = "${var.cluster-short-name}-gke-services"
        ip_cidr_range = var.vpc-services-range
      }
    ]
  }
}

resource "google_compute_address" "KUBE_CORE_CLUSTER_CONFIG_SHORT_NAME-nat-ip" {
  name    = "${var.cluster-short-name}-nat-ip"
  project = var.project
  region  = var.region
}

module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  # version = "~> 0.4"

  name    = "${var.cluster-short-name}-router"
  project = var.project
  region  = var.region
  network = module.vpc.network_self_link
  nats    = [{
    name    = "${var.cluster-short-name}-nat-gateway"
    nat_ips = [
      google_compute_address.KUBE_CORE_CLUSTER_CONFIG_SHORT_NAME-nat-ip.self_link
    ]
  }]
}
