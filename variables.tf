variable "location" {
  description = "Azure region name"
}

variable "environment" {
  description = "Environment name"
}

variable "projectname" {
  description = "Project name (used for resource group & others) only alphanumerical"
}

variable "vmname" {
  description = "Virtual machine name"
}

variable "billing" {
  description = "Billing code"
}

variable "owner" {
  description = "Owner"
}

locals {
  common_tags = {
    environment = "${var.environment}"
    billing     = "${var.billing}"
    project     = "${var.projectname}"
    owner       = "${var.owner}"
  }
}
