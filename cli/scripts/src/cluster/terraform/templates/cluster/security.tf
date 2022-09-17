resource "google_compute_firewall" "KUBE_CORE_CLUSTER_CONFIG_SHORT_NAME-access-l4-lb" {
  name    = "${var.cluster-short-name}-access-l4-lb"
  project = var.project
  network = module.vpc.network_self_link

  allow {
    protocol = "tcp"
    ports = [
      "80",
      "443",
      "9443"
    ]
  }

  target_tags   = ["gke-${var.cluster-short-name}"]
  source_ranges = var.lb-source-range # allow all, as security is handled in kubernetes ingresses
}

resource "google_compute_firewall" "KUBE_CORE_CLUSTER_CONFIG_SHORT_NAME-gke" {
  name    = "gke-${var.cluster-short-name}-custom-master"
  project = var.project
  network = module.vpc.network_self_link

  allow {
    protocol = "tcp"
    ports = var.master-allowed-ports
  }

  target_tags   = ["gke-${var.cluster-short-name}"]
  source_ranges = [cidrsubnet(cidrsubnet(module.vpc.subnets["${var.region}/${var.cluster-short-name}-gke"].ip_cidr_range, -8, 0), 12, 512)]
}

resource "google_compute_firewall" "KUBE_CORE_CLUSTER_CONFIG_SHORT_NAME-iap-resources" {
  name    = "${var.cluster-short-name}-iap-resources"
  project = var.project
  network = module.vpc.network_self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = [
    "gke-${var.cluster-short-name}"
  ]
  source_ranges = var.iap-range # IAP
}
