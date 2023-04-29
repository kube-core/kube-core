resource "google_container_registry" "gcr" {
  project  = var.project
  location = var.region-shortname
}
