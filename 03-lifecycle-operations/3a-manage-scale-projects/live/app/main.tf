terraform {
  backend "local" {
    path = "../../state/app.tfstate"
  }
}

data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../../state/network.tfstate"
  }
}

module "app" {
  source  = "../../modules/app"
  name    = "shop"
  subnets = data.terraform_remote_state.network.outputs.subnets
}

output "instances" {
  value = module.app.instances
}
