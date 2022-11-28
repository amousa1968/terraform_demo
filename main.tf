#####################################
#       Host project creation
#####################################

provider "google" {
    project     = "sixth-backbone-341422"
    credentials="dev2-terraform.json"
}

/*
resource "google_project" "my_project" {
#  name       = "My Project Test1"
#  project_id = "sixth-backbone-341422"
#  project_id  = var.project_id
  org_id     = "508698796108"
}
*/

module "sixth-backbone" {
    source = "./modules/environments/"
    region      = var.region
    org_id = var.org_id
    billing_account_id = var.billing_account_id
    environment_type = "host"
    project_base_name = var.project_base_name
}

/*
# Top-level folder under an organization.
resource "google_folder" "ayman-test" {
  display_name = "ayman-test"
  parent       = "onixdev2/508698796108"
}
*/

/*
# Folder nested under another folder.
resource "google_folder" "ayman-testgcp" {
  display_name = "ayman-testgcp"
  parent       = "onixdev2.com/508698796108"
}

*/

/*
##################################
#       VPCs
##################################

# transit
module "transit-vpc" {
    source = "./modules/vpc"
    region      = var.region
    host_project = module.sixth-backbone.project_id
    vpc_name = "wusc-transit-vpc"
    subnets = [
        {
            name = "transit-na-ne1-10-150-96"
            cidr = "10.150.96.0/22"
        }
    ]
}

# sharedresources
module "sharedresources-vpc" {
    source = "./modules/vpc"
    region      = var.region
    host_project = module.sixth-backbone.project_id
    vpc_name = "wusc-sharedresources-vpc"
    subnets = [
        {
            name = "sharedresources-na-ne1-10-150-100"
            cidr = "10.150.100.0/22"
        }
    ]
}


# prod
module "prod-vpc" {
    source = "./modules/vpc"
    region      = var.region
    host_project = module.sixth-backbone.project_id
    vpc_name = "wusc-prod-vpc"
    subnets = [
        {
            name = "prod-public-na-ne1-10-150-0"
            cidr = "10.150.0.0/22"
        },
        {
            name = "prod-private-na-ne1-10-150-16"
            cidr = "10.150.16.0/22"
        }
    ]
}

# dev
module "dev-vpc" {
    source = "./modules/vpc"
    region      = var.region
    host_project = module.sixth-backbone.project_id
    vpc_name = "wusc-dev-vpc"
    subnets = [
        {
            name = "dev-public-na-ne1-10-150-64"
            cidr = "10.150.64.0/22"
        },
        {
            name = "dev-private-na-ne1-10-150-80"
            cidr = "10.150.80.0/22"
        }
    ]
}

# qa
module "qa-vpc" {
    source = "./modules/vpc"
    region      = var.region
    host_project = module.sixth-backbone.project_id
    vpc_name = "wusc-qa-vpc"
    subnets = [
        {
            name = "qa-public-na-ne1-10-150-32"
            cidr = "10.150.32.0/22"
        },
        {
            name = "qa-private-na-ne1-10-150-48"
            cidr = "10.150.48.0/22"
        }
    ]
}


##################################
#       Peerings between VPCs
##################################


module "sharedresources-transit" {
    source = "./modules/peering/"
    subnet1 = module.sharedresources-vpc.self_link
    subnet1-name = module.sharedresources-vpc.name
    subnet2 = module.transit-vpc.self_link
    subnet2-name = module.transit-vpc.name
}

module "transit-prod" {
    source = "./modules/peering/"
    subnet1 = module.transit-vpc.self_link
    subnet1-name = module.transit-vpc.name
    subnet2 = module.prod-vpc.self_link
    subnet2-name = module.prod-vpc.name
}

module "transit-qa" {
    source = "./modules/peering/"
    subnet1 = module.transit-vpc.self_link
    subnet1-name = module.transit-vpc.name
    subnet2 = module.qa-vpc.self_link
    subnet2-name = module.qa-vpc.name
}

module "transit-dev" {
    source = "./modules/peering/"
    subnet1 = module.transit-vpc.self_link
    subnet1-name = module.transit-vpc.name
    subnet2 = module.dev-vpc.self_link
    subnet2-name = module.dev-vpc.name
}

module "sharedresources-prod" {
    source = "./modules/peering/"
    subnet1 = module.sharedresources-vpc.self_link
    subnet1-name = module.sharedresources-vpc.name
    subnet2 = module.prod-vpc.self_link
    subnet2-name = module.prod-vpc.name
}

module "sharedresources-qa" {
    source = "./modules/peering/"
    subnet1 = module.sharedresources-vpc.self_link
    subnet1-name = module.sharedresources-vpc.name
    subnet2 = module.qa-vpc.self_link
    subnet2-name = module.qa-vpc.name
}

module "sharedresources-dev" {
    source = "./modules/peering/"
    subnet1 = module.sharedresources-vpc.self_link
    subnet1-name = module.sharedresources-vpc.name
    subnet2 = module.dev-vpc.self_link
    subnet2-name = module.dev-vpc.name
}

##################################
#       Prod/qa/dev env
##################################

module "wusc-prod"{
    source = "./modules/environments/"
    region      = var.region
    org_id = var.org_id
    billing_account_id = var.billing_account_id
    environment_type = "prod"
    project_base_name = var.project_base_name
}

module "wusc-qa"{
    source = "./modules/environments/"
    region      = var.region
    org_id = var.org_id
    billing_account_id = var.billing_account_id
    environment_type = "qa"
    project_base_name = var.project_base_name
}

module "wusc-dev"{
    source = "./modules/environments/"
    region      = var.region
    org_id = var.org_id
    billing_account_id = var.billing_account_id
    environment_type = "dev"
    project_base_name = var.project_base_name
}


##################################
#       Shared VPC
##################################

module "shared_vpc_prod" {
    source = "./modules/shared-vpc/"
    host_project = module.sixth-backbone.project_id
    service_project = module.wusc-prod.project_id
    }

module "shared_vpc_qa" {
    source = "./modules/shared-vpc/"
    host_project = module.sixth-backbone.project_id
    service_project = module.wusc-qa.project_id
    }


module "shared_vpc_dev" {
    source = "./modules/shared-vpc/"
    host_project = module.sixth-backbone.project_id
    service_project = module.wusc-dev.project_id
    }

*/

