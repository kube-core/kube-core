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

variable "env" {
  default = "dev"
}

variable "project-short-name" {
  default = "KUBE_CORE_CLOUD_PROJECT"
}

variable "cluster-short-name" {
  default = "KUBE_CORE_CLUSTER_CONFIG_SHORT_NAME"
}

# Kubernetes
variable "kubernetes-version" {
  default = "KUBE_CORE_CLUSTER_SPECS_KUBERNETES_VERSION"
}

# Security
variable "lb-source-range" {
  default = [
      "0.0.0.0/0",
    ]
}

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

variable "iap-range" {
  default = [
      "35.235.240.0/20",
    ]
}

# GCR
variable "gcr-admin" {
  default = [
      "group:KUBE_CORE_CLUSTER_CONFIG_ADMIN_EMAIL",
    ]
}
