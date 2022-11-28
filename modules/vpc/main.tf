############################
# VPC Creation
############################

resource "google_compute_network" "vpc" {
    name = var.vpc_name
    project = var.host_project
    auto_create_subnetworks = false
    routing_mode = "GLOBAL"
}


############################
# Subnetwork creation
############################


## public

resource "google_compute_subnetwork" "subnet" {
    for_each = {for subnet in var.subnets: subnet.name => subnet }
    name = each.value.name
    ip_cidr_range = each.value.cidr
    region        = var.region
    project = var.host_project
    network       = google_compute_network.vpc.id
    private_ip_google_access = true
    log_config { 
        aggregation_interval = "INTERVAL_10_MIN" 
        flow_sampling = 0.5 
        metadata = "INCLUDE_ALL_METADATA" 
    }
}


resource "google_compute_firewall" "crosstalk" {
  project     = var.host_project
  name        = "${var.vpc_name}-ingress-crosstalk-all"
  network     = google_compute_network.vpc.id
  description = "Allows communication for internal instances"

  allow {
    protocol  = "all"
  }

  priority = "65534"

  source_ranges = ["10.128.0.0/9"]
  target_tags = ["internal"]
}

# Public SSH

resource "google_compute_firewall" "rule-ssh" {
  project     = var.host_project
  name        = "${var.vpc_name}-allow-ssh"
  network     = google_compute_network.vpc.id
  description = "Public SSH"

  allow {
    protocol  = "tcp"
    ports = ["22"]
  }

  priority = "65532"

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["internal"]
}

# Public RDP

resource "google_compute_firewall" "rule-rdp" {
  project     = var.host_project
  name        = "${var.vpc_name}-allow-rdp"
  network     = google_compute_network.vpc.id
  description = "Public RDP"

  allow {
    protocol  = "tcp"
    ports = ["3389"]
  }

  priority = "65531"

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["internal"]
}

# IAP

resource "google_compute_firewall" "rule-iap" {
  project     = var.host_project
  name        = "${var.vpc_name}-allow-iap"
  network     = google_compute_network.vpc.id
  description = "IAP"

  allow {
    protocol  = "tcp"
    ports = ["22", "3389"]
  }

  priority = "65533"

  source_ranges = ["35.235.240.0/20"]
  target_tags = ["internal"]
}

