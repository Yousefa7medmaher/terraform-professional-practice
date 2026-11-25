terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "< 3.6"
    }
  }
}

resource "random_string" "x" {
  length = 4
}
