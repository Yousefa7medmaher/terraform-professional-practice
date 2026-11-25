terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
  }
}

variable "name" {
  type        = string
  description = "Short app name, used as a prefix."
}

variable "secret_length" {
  type    = number
  default = 16
}

resource "random_pet" "name" {
  prefix = var.name
}

resource "random_password" "secret" {
  length = var.secret_length
}

resource "terraform_data" "server" {
  input = random_pet.name.id
}

output "server_name" {
  value = terraform_data.server.output
}
