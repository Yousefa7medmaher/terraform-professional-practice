terraform {
  required_version = ">= 1.10.0"
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.65"
    }
  }
}

# Token from `terraform login` or TFE_TOKEN env var
provider "tfe" {
  organization = var.organization
}

variable "organization" {
  type        = string
  description = "Your HCP Terraform organization name"
}
