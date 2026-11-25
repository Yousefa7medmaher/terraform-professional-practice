terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
  }
}

variable "keys" {
  type = set(string)
}

resource "random_string" "key" {
  for_each = var.keys
  length   = 8
  special  = false
}
