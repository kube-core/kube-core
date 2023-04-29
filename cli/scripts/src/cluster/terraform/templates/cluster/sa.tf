resource "google_service_account" "gke" {
  project      = var.project
  account_id   = "${var.cluster-short-name}-gke"
  display_name = "${var.cluster-short-name}-gke"
}

## https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster#permissions
resource "google_project_iam_member" "cluster_service_account-hardened_minimal_role" {
  project = var.project
  role    = "roles/container.nodeServiceAccount"
  member  = "serviceAccount:${google_service_account.gke.email}"
}
