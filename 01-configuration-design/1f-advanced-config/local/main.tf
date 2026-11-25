terraform {
  required_version = ">= 1.10.0"
}

variable "app_version" {
  type    = string
  default = "1.0.0"
}

variable "replicas" {
  type    = number
  default = 2
}

resource "terraform_data" "release" {
  input = var.app_version
}

resource "terraform_data" "deploy" {
  input = {
    replicas = var.replicas
  }

  lifecycle {
    replace_triggered_by = [terraform_data.release]

    precondition {
      condition     = var.replicas > 0
      error_message = "replicas must be at least 1."
    }

    postcondition {
      condition     = self.output.replicas == var.replicas
      error_message = "Deployed replicas don't match the request."
    }
  }
}

resource "terraform_data" "database" {
  input = "critical-db"

  lifecycle {
    prevent_destroy = true
  }
}

check "replicas_ha" {
  assert {
    condition     = var.replicas >= 3
    error_message = "WARNING: fewer than 3 replicas is not highly available."
  }
}
