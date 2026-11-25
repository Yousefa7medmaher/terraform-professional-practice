terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
    }
  }
}

variable "name" {
  type = string
}

variable "environment" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

locals {
  versioning = var.environment == "prod"
}

resource "local_file" "manifest" {
  filename = "${path.root}/manifests/${var.name}.json"
  content = jsonencode({
    name       = var.name
    versioning = local.versioning
    tags       = var.tags
  })
}

output "name" {
  value = var.name
}

output "versioning" {
  value = local.versioning
}
