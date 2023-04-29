terraform {
  backend "gcs" {
    bucket      = "gke-KUBE_CORE_CLUSTER_CONFIG_SHORT_NAME-terraform-state"
    prefix      = "cluster"
  }
}
