data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "../shared-state/network.tfstate"
  }
}

output "from_network" {
  value = {
    vpc     = data.terraform_remote_state.network.outputs.vpc_id
    subnets = data.terraform_remote_state.network.outputs.private_subnet_ids
  }
}
