resource "google_compute_firewall" "KUBE_CORE_CLUSTER_CONFIG_SHORT_NAME-access-l4-lb" {
  name        = "${var.cluster-short-name}-access-l4-lb"
  project     = var.project
  network     = module.vpc.network_self_link
  description = "IP ranges authorized to access VPC ingress of ${var.cluster-short-name}"
  allow {
    protocol = "tcp"
    ports = [
      "80",
      "443",
      "9443"
    ]
  }
  target_tags   = ["gke-${var.cluster-short-name}"]
  source_ranges = var.lb-source-range
}

resource "google_compute_firewall" "KUBE_CORE_CLUSTER_CONFIG_SHORT_NAME-gke" {
  name        = "gke-${var.cluster-short-name}-custom-master"
  project     = var.project
  network     = module.vpc.network_self_link
  description = "Open required ports by custom ressources in GKE controlplane ${var.cluster-short-name}"
  allow {
    protocol = "tcp"
    ports = var.master-allowed-ports
  }
  target_tags   = ["gke-${var.cluster-short-name}"]
  source_ranges = ["${var.vpc-controlplane-range}"]
}

resource "google_compute_firewall" "KUBE_CORE_CLUSTER_CONFIG_SHORT_NAME-iap-resources" {
  name         = "${var.cluster-short-name}-iap-resources"
  project      = var.project
  network      = module.vpc.network_self_link
  description = "This rule permits to use GCP IAP to ssh in target instances"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = [
    "gke-${var.cluster-short-name}"
  ]
  source_ranges = var.gcp-iap-range
}
