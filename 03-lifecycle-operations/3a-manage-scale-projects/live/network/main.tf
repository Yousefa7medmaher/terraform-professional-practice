terraform {
  backend "local" {
    path = "../../state/network.tfstate"
  }
}

module "network" {
  source = "../../modules/network"
  name   = "main"
  cidr   = "10.10.0.0/16"
}

output "vpc_id" {
  value = module.network.vpc_id
}

output "subnets" {
  value = module.network.subnets
}
