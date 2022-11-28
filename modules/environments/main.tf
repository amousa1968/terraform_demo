############################
#     Projects creation
############################


# Generates a random ids for the project
resource "random_id" "id" {
  byte_length = 6
}

# Generates a random name
resource "random_pet" "pet" {
}

resource "google_project" "project" {
  name       = "${var.project_base_name}-${var.environment_type}"
  project_id = "${random_pet.pet.id}-${random_id.id.hex}"
  org_id     = var.org_id
  billing_account = var.billing_account_id
  auto_create_network = false
  labels = {
    "environment" = var.environment_type
    "managed-by-terraform" = "true"
  }
}

# Activates the compute engine api (required for shared vpc)

resource "google_project_service" "compute" {
  project = google_project.project.project_id
  service = "compute.googleapis.com"
  disable_dependent_services = true
}