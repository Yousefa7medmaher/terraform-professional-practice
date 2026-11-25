variable "tiers" {
  type    = list(string)
  default = ["web", "app", "db"]
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "users" {
  type = map(object({
    role = string
  }))
  default = {
    alice = { role = "admin" }
    bob   = { role = "dev" }
  }
}

locals {
  # Nested loop: tiers x AZs  -> 6 objects
  subnet_list = flatten([
    for t_idx, tier in var.tiers : [
      for a_idx, az in var.azs : {
        key  = "${tier}-${az}"
        tier = tier
        az   = az
        cidr = cidrsubnet("10.0.0.0/16", 8, t_idx * 10 + a_idx)
      }
    ]
  ])

  # Convert to a map with stable keys for for_each
  subnets = { for s in local.subnet_list : s.key => s }
}

resource "local_file" "subnet" {
  for_each = local.subnets

  filename = "${path.module}/out/subnets/${each.key}.txt"
  content  = "tier=${each.value.tier} az=${each.value.az} cidr=${each.value.cidr}"
}

# Filter while looping: only admins get a file
resource "local_file" "team_file" {
  for_each = { for name, u in var.users : name => u if u.role == "admin" }

  filename = "${path.module}/out/admins/${each.key}.txt"
  content  = each.value.role
}

# Reading for_each resources back
output "subnet_cidrs" {
  value = { for k, f in local_file.subnet : k => local.subnets[k].cidr }
}

output "all_subnet_files" {
  value = values(local_file.subnet)[*].filename
}
