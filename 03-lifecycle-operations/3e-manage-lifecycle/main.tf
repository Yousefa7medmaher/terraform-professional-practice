resource "random_pet" "old_name" {}

resource "random_string" "token" {
  length  = 12
  special = false
}

resource "random_pet" "sandbox" {
  prefix = "sandbox"
}

resource "random_pet" "x" {}
