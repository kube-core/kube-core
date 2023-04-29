resource "google_dns_managed_zone" "dns_zone" {
  description   = "domain managed by Terraform"
  dns_name      = "KUBE_CORE_CLUSTER_CONFIG_DOMAIN."
  force_destroy = false
  name          = "KUBE_CORE_CLUSTER_CONFIG_DOMAIN"
  project       = var.project
  visibility    = "public"
}
