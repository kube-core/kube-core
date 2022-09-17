resource "google_dns_managed_zone" "dns_zone" {
  description   = "domain managed by Terraform"
  dns_name      = "KUBE_CORE_CLUSTER_CONFIG_SHORT_NAME.KUBE_CORE_CLOUD_PROJECT_SHORT_NAME.KUBE_CORE_ORG_DOMAIN"
  force_destroy = true
  name          = "KUBE_CORE_CLUSTER_CONFIG_SHORT_NAME.KUBE_CORE_CLOUD_PROJECT_SHORT_NAME.KUBE_CORE_ORG_DOMAIN"
  project       = var.project
  visibility    = "public"
}
