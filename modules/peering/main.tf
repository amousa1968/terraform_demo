resource "google_compute_network_peering" "peering1" {
  name         = "${var.subnet1-name}-${var.subnet2-name}"
  network      = var.subnet1
  peer_network = var.subnet2
}

resource "google_compute_network_peering" "peering2" {
  name          = "${var.subnet2-name}-${var.subnet1-name}"
  network       = var.subnet2
  peer_network  = var.subnet1
}