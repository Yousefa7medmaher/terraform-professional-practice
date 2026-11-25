variable "owner" {
  type        = string
  description = "Who owns this stack"
}

data "local_file" "settings" {
  filename = "${path.module}/settings.json"
}

locals {
  settings = jsondecode(data.local_file.settings.content)
}

module "child" {
  source   = "./modules/child"
  owner    = var.owner
  replicas = local.settings.replicas
}

output "greeting" {
  value = "Hello ${var.owner}, region is ${local.settings.region}"
}

output "child_summary" {
  value = module.child.summary
}
