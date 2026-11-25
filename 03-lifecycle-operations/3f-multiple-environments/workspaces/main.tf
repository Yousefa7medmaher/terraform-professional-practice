locals {
  settings = {
    default = { size = "small", count = 1 }
    dev     = { size = "small", count = 1 }
    prod    = { size = "large", count = 3 }
  }
  env = local.settings[terraform.workspace]
}

resource "terraform_data" "server" {
  count = local.env.count
  input = "${terraform.workspace}-${local.env.size}-${count.index}"
}

output "servers" {
  value = terraform_data.server[*].output
}
