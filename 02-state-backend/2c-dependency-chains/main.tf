terraform {
  required_version = ">= 1.10.0"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

resource "random_pet" "name" {}

resource "random_password" "db" {
  length = 16
}

# Implicit dependency on random_pet.name (reference)
resource "local_file" "app_config" {
  filename = "${path.module}/out/${random_pet.name.id}.conf"
  content  = "app=${random_pet.name.id}"

  # Explicit dependency: no reference, but must run after the password exists
  depends_on = [random_password.db]
}

# Step 3 of the lab: uncomment to see the version conflict at init.
# module "legacy" {
#   source = "./modules/legacy"
# }
