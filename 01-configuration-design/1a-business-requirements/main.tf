resource "random_id" "suffix" {
  byte_length = 2
}

locals {
  # Cartesian product: every team x every environment
  storage_areas = {
    for pair in setproduct(keys(var.teams), var.environments) :
    "${pair[0]}-${pair[1]}" => {
      team        = pair[0]
      environment = pair[1]
      cost_center = var.teams[pair[0]].cost_center
      owner_email = var.teams[pair[0]].owner_email
    }
  }
}

module "storage" {
  source   = "./modules/storage-area"
  for_each = local.storage_areas

  name        = lower("${each.key}-${random_id.suffix.hex}")
  environment = each.value.environment
  tags = {
    team        = each.value.team
    cost_center = each.value.cost_center
    owner       = each.value.owner_email
  }
}
