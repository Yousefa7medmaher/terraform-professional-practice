terraform {
  required_version = ">= 1.10.0"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 5.0"
    }
  }
}

provider "vault" {} # uses VAULT_ADDR and VAULT_TOKEN

# Ephemeral: read at run time, not stored in state
ephemeral "vault_kv_secret_v2" "app" {
  mount = "secret"
  name  = "app"
}

# Anti-pattern for comparison (stored in state):
# data "vault_kv_secret_v2" "app" {
#   mount = "secret"
#   name  = "app"
# }

locals {
  db_password = ephemeral.vault_kv_secret_v2.app.data["db_password"]
}
