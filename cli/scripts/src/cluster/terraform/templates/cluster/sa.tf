resource "google_service_account" "gke" {
  project      = var.project
  account_id   = "${var.cluster-short-name}-gke"
  display_name = "${var.cluster-short-name}-gke"
}
