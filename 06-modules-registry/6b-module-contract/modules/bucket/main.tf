terraform {
  required_version = ">= 1.3.0"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">= 2.0"
    }
  }
}

resource "local_file" "bucket" {
  filename = "${path.root}/out/${var.name}.json"
  content = jsonencode({
    name           = var.name
    versioning     = var.config.versioning
    tier           = var.config.tier
    lifecycle_days = var.lifecycle_days
    tags           = var.config.tags
  })
}
