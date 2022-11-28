# terraform_demo
Terraform Demo Project setup project host and resources on gcp

### Build Infrastructure - Terraform GCP for WUSC
- build infrastructure on Google Cloud Platform (GCP) for WUSC.

## Prerequisites
- A Google Cloud Platform account 
- Terraform installed

## Set up GCP
- GCP account, create or modify resources to enable Terraform to provision your infrastructure
- Organizes: GCP organizes resources into projects
- Project: dev
- Project: staging
- Project: prod

* Create the projects in the GCP console and make note of each projects ID's for (dev, staging, prod). You can see a list of your projects in the cloud resource manager.

* Google Compute Engine: Enable Google Compute Engine for your project in the GCP console. Make sure to select the project you are using to follow and click the "Enable" button.

* A GCP service account key for WUSC: The service account key to enable Terraform to access GCP using the provided account. Copy the account key, use the following:

- Select the project you created in the previous step.
- Click "Create Service Account".
- Give it any name you like and click "Create".
- For the Role, choose "Project -> Editor", then click "Continue".
- Skip granting additional users access, and click "Done".
- After you create your service account, download your service account key.

## How do I find my GCP service key?
- Creating service account keys
- In the Cloud Console, go to the Service accounts page.
- Select a project.
- Click the email address of the service account that you want to create a key for.
- Click the Keys tab.
- Click the Add key drop-down menu, then select Create new key.
- Select JSON as the Key type and click Create.

Select your service account from the list.
Select the "Keys" tab.
In the drop down menu, select "Create new key".
Leave the "Key Type" as JSON.
Click "Create" to create the key and save the key file to your system.

## Terraform create manage resources - work-flow (dev, staging, prod)

## Write configuration
- The set of files used to describe infrastructure in Terraform is known as a Terraform configuration.
- First configuration to create a network.
- Create a directory for the configuration.
- mkdir dev-terraform-gcp
- Change to the directory. (dev-terraform-gcp)
- $ cd dev-terraform-gcp
- Create a main.tf file for the configuration.
- $ touch main.tf
- Open main.tf in a text editor, and paste in the configuration below. 
- Replace the <NAME> with the path to the service account key file saved to your system and <PROJECT_ID> with your project's ID, and save the file.

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("<NAME>.json")

  project = "<PROJECT_ID>"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

## Terraform Block
- terraform {} block contains Terraform settings, provider use to provision infrastructure. 

Here is a basic outline of a dynamic block syntax resource:

resource "resource_type" "name" {
  // Other resource settings
 
  dynamic "setting" {
    for_each = var.settings
    content {
      property1 = setting.value.<property>
      // etc.
    }
  }
}


- Provider, the source attribute defines an optional hostname, a namespace, and the provider type. 
- The default configuration GCP 'google' provider's source is defined as hashicorp/google, which is shorthand for registry.terraform.io/hashicorp/google.
- A provider requirement consists of:
-- local name
-- source location
-- version constraint

following configuration declares wusc as the local name for mycorp/wusc, then uses that local name when configuring the provider:

terraform {
  required_providers {
    wusc = {
      source  = "mycorp/wusc"
      version = "~> 1.0"
    }
  }
}

## Providers
- google 'GCP'

## Resource
- google_compute_network
- vpc_network
- resource type and resource name form a unique ID for your network is 'google_compute_network.vpc_network'.

## Initialize the directory
- $ terraform init

## Format and validate the configuration
- terraform fmt
next run, 
- terraform validate 

## Create infrastructure
- $ terraform apply
- Enter a value: yes

## Inspect state
- When you applied your configuration, Terraform wrote data into a file called terraform.tfstate
- Inspect the current state using terraform show

## Terraform: Structure working environment Directory & Terraform pre-config
- environments/:
## Dev Terraform files
- dev/wusc-dev
configs.tf
providers.tf
vpc.tf

Under data/
credentials/: Put your credentials here. For example, public ssh key.
launch-configs/: Put your GCP Launch Configuration here
policies/: Put your IAM policies here
scripts/: account_id

## QA Terraform files
- qa/wusc-qa/
configs.tf
providers.tf
vpc.tf
data/
Under data/
credentials/: Put your credentials here. For example, public ssh key.
launch-configs/: Put your GCP Launch Configuration here
policies/: Put your IAM policies here
scripts/: account_id

## Production Terraform files
- prod/wusc-prod
configs.tf
providers.tf
vpc.tf
data/
Under data/
credentials/: Put your credentials here. For example, public ssh key.
launch-configs/: Put your GCP Launch Configuration here
policies/: Put your IAM policies here
scripts/: account_id

## wusc-devops
- CLOUD SOURCE REPOSITORIES
- CLOUD STORAGE

