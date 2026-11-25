terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }
}

variable "environment" {
  type    = string
  default = "dev"
}

locals {
  instance_count = var.environment == "prod" ? 3 : 1
}

resource "random_pet" "instance" {
  count  = local.instance_count
  prefix = "web-${var.environment}-${count.index}"
  length = 1
}

output "instance_names" {
  value = random_pet.instance[*].id
}
