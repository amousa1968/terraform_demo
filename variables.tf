variable "region" {
    type = string
    description = "The region where to deploy the resources"
    default = "northamerica-northeast1"
}

variable "org_id" {
    type = string
    description = "The org ID the projects will live under"
    default = "508698796108"
}

variable "billing_account_id" {
    type = string
    description = "The billing account id to use"
    default = "00F848-4585D6-07E2B4"
}

variable "project_base_name" {
    type = string
    description = "The base name of the project"
    default = "myproject"
}

variable "project_id" {
  description = "The ID to give the project. If not provided, the `name` will be used."
  type        = string
#  default     = ""
}
