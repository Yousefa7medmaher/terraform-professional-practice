terraform {
  required_version = ">= 1.11.0"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }
}

variable "api_key" {
  type      = string
  sensitive = true
}

variable "session_token" {
  type      = string
  ephemeral = true # never stored in state or plan
  default   = "temporary-token"
}

# Normal resource: the result is STORED in state
resource "random_password" "stored" {
  length = 16
}

# Ephemeral resource: generated each run, NEVER stored
ephemeral "random_password" "not_stored" {
  length = 16
}

locals {
  # locals may hold ephemeral values
  auth_header = "Bearer ${var.session_token}"
}

output "api_key_out" {
  value     = var.api_key
  sensitive = true
}
