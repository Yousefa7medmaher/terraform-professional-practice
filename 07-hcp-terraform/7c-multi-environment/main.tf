locals {
  environments = {
    dev   = { auto_apply = true }
    stage = { auto_apply = true }
    prod  = { auto_apply = false }
  }
}

variable "terraform_versions" {
  description = "Terraform version constraint per environment (used in lab 7d)."
  type        = map(string)
  default = {
    dev   = "~> 1.14.0"
    stage = "~> 1.14.0"
    prod  = "~> 1.14.0"
  }
}

resource "tfe_project" "app" {
  name = "practice-app"
}

resource "tfe_workspace" "app" {
  for_each = local.environments

  name              = "app-${each.key}"
  project_id        = tfe_project.app.id
  auto_apply        = each.value.auto_apply
  terraform_version = var.terraform_versions[each.key]
}

resource "tfe_variable" "environment" {
  for_each = tfe_workspace.app

  workspace_id = each.value.id
  key          = "environment"
  value        = each.key
  category     = "terraform"
}

# ---- shared values for the whole project ----
resource "tfe_variable_set" "aws_common" {
  name        = "aws-common"
  description = "Shared AWS settings for practice-app"
  priority    = true # workspaces can't override these
}

resource "tfe_variable" "region" {
  variable_set_id = tfe_variable_set.aws_common.id
  key             = "AWS_REGION"
  value           = "us-east-1"
  category        = "env"
}

resource "tfe_variable" "dyn_creds" {
  variable_set_id = tfe_variable_set.aws_common.id
  key             = "TFC_AWS_PROVIDER_AUTH"
  value           = "true"
  category        = "env"
}

resource "tfe_project_variable_set" "aws_common" {
  project_id      = tfe_project.app.id
  variable_set_id = tfe_variable_set.aws_common.id
}

# ---- state sharing ----
resource "tfe_workspace" "network_prod" {
  name       = "network-prod"
  project_id = tfe_project.app.id
}

resource "tfe_workspace_settings" "network_prod" {
  workspace_id              = tfe_workspace.network_prod.id
  global_remote_state       = false
  remote_state_consumer_ids = [tfe_workspace.app["prod"].id]
}
