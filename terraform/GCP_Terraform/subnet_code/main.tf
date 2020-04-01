resource "google_compute_network" "udemy" {
  name                    = "udemy-network"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "network" {
  name          = "udemy-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = "${google_compute_network.udemy.self_link}"
}
