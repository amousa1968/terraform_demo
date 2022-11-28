############################
#     Shared VPC
############################

# A host project provides network resources to associated service projects.
resource "google_compute_shared_vpc_host_project" "host" {
  project = var.host_project
}

resource "google_compute_shared_vpc_service_project" "wusc-prod-vpc" {
    host_project    = google_compute_shared_vpc_host_project.host.project
    service_project = var.service_project
}
