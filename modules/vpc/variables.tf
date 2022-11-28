variable "region" {
    type = string
    description = "The region where to deploy the resources"
    default = ""
} 

variable "host_project" {
    type        = string
    description = "The id of the host project"
    default     = ""
}

variable "vpc_name" {
    type = string
    description = "The name of the VPC"
}

variable "subnets" {
  type = list(object({
    name = string
    cidr = string
  }))
    description = "A list of subnetworks to create in that VPC"
}