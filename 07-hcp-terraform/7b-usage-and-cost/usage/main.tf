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

data "tfe_organization" "this" {
  name = var.organization
}

data "tfe_workspace_ids" "all" {
  names = ["*"]
}

output "org_email" {
  value = data.tfe_organization.this.email
}

output "workspace_count" {
  value = length(data.tfe_workspace_ids.all.ids)
}
