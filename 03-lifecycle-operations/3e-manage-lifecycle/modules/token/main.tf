terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
  }
}

resource "random_string" "this" {
  length  = 12
  special = false
}

output "value" {
  value = random_string.this.result
}
