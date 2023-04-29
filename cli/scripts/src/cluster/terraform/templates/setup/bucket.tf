module "gcs_buckets" {
  source  = "terraform-google-modules/cloud-storage/google"
  version = "~> 3.4"
  project_id  = var.project
  names = ["gke-KUBE_CORE_CLUSTER_CONFIG_SHORT_NAME-terraform-state"]
  # prefix = "my-unique-prefix"
  set_admin_roles = true
  admins = ["group:KUBE_CORE_CLUSTER_CONFIG_ADMIN_EMAIL"]
  versioning = {
    first = true
  }
}
