variable "region" {
  default = "KUBE_CORE_CLOUD_DEFAULT_LOCATION"
}

variable "region-shortname" {
  default = "EU"
}

variable "main-zone" {
  default = "KUBE_CORE_CLOUD_DEFAULT_LOCATION-b"
}

variable "zones" {
  default = [
      "KUBE_CORE_CLOUD_DEFAULT_LOCATION-b",
    ]
}

variable "project" {
  default = "KUBE_CORE_CLOUD_PROJECT"
}

variable "project-number" {
  default = ""
}

variable "env" {
  default = "dev"
}

variable "project-short-name" {
  default = "KUBE_CORE_CLOUD_PROJECT"
}

variable "cluster-short-name" {
  default = "KUBE_CORE_CLUSTER_CONFIG_SHORT_NAME"
}

# Kubernetes minimal version
variable "kubernetes-version" {
  default = "KUBE_CORE_CLUSTER_SPECS_KUBERNETES_VERSION"
}

# IPs whitelisted to access l4 loadbalancer serving gke ingress
# Allow all, as security is handled on kubernetes ingress
variable "lb-source-range" {
  default = [
      "0.0.0.0/0",
    ]
}

# IPs whitelisted to access the gke controlplane
variable "master-authorized-networks" {
  default = [
    {
      cidr_block   = "KUBE_CORE_CLUSTER_CONFIG_NETWORK_MASTER"
      display_name = "Main authorized range (Admin)"
    },
  ]
}

# Range /24 theorically corresponds to 256 nodes
variable "vpc-subnet-range" {
  default = "KUBE_CORE_CLUSTER_CONFIG_NETWORK_VPC_SUBNET_RANGE"
}

# Range /17 corresponds to 32,768 pods
variable "vpc-pods-range" {
  default = "KUBE_CORE_CLUSTER_CONFIG_NETWORK_VPC_PODS_RANGE"
}

# Range /20 corresponds to 4,096 services
variable "vpc-services-range" {
  default = "KUBE_CORE_CLUSTER_CONFIG_NETWORK_VPC_SERVICES_RANGE"
}

# Private cluster require a dedicated non-overlapping /28 ranges for controlplane
variable "vpc-controlplane-range" {
  default = "KUBE_CORE_CLUSTER_CONFIG_NETWORK_VPC_CONTROLPLANE_RANGE"
}

# 128 pods, permits 128 nodes, 64 pods permits 256 nodes
variable "max-pods-per-node" {
  default = "KUBE_CORE_CLUSTER_CONFIG_NETWORK_MAX_PODS_PER_NODE"
}

# Ports to open in GKE controlplane
variable "master-allowed-ports" {
  default = [
      "8443",  # mutating webhook prometheus operator
      "6443",  # prometheus adapter
      "443",   # istio
      "10250", # istio
      "15017", # istio
      "8080",  # istio/kiali
      "15000", # istio/kiali
    ]
}

# This range correspond GCP IAP source
variable "gcp-iap-range" {
  default = [
      "35.235.240.0/20",
    ]
}


# GCR
variable "admin-email" {
  default = [
      "group:KUBE_CORE_CLUSTER_CONFIG_ADMIN_EMAIL",
    ]
}
