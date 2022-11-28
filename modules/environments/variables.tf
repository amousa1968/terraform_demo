variable "project_base_name" {
    type = string
    description = "The base name of the project"
    default = ""
}

variable "org_id" {
    type = string
    description = "The org ID the projects will live under"
}

variable "billing_account_id" {
    type = string
    description = "The billing account id to use"
}

variable "region" {
    type = string
    description = "The region where to deploy the resources"
    default = ""
} 

variable "environment_type" {
    type = string
    description = "The type of environment to create (prod/qa/dev)"
}