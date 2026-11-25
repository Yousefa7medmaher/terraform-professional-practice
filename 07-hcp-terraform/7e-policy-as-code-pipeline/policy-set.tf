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

variable "github_repo" {
  type    = string
  default = "Yousefa7medmaher/terraform-professional-practice"
}

variable "oauth_token_id" {
  type        = string
  description = "VCS OAuth token id from Organization settings -> VCS providers"
}

data "tfe_project" "app" {
  name = "practice-app"
}

resource "tfe_policy_set" "instance_types" {
  name          = "restrict-instance-types"
  description   = "Only small EC2 instance types"
  kind          = "sentinel"
  policies_path = "07-hcp-terraform/7e-policy-as-code-pipeline/policies"

  vcs_repo {
    identifier     = var.github_repo
    branch         = "main"
    oauth_token_id = var.oauth_token_id
  }
}

resource "tfe_project_policy_set" "app" {
  policy_set_id = tfe_policy_set.instance_types.id
  project_id    = data.tfe_project.app.id
}
