terraform {
  backend "local" {
    path = "../shared-state/network.tfstate"
  }
}

output "vpc_id" {
  value = "vpc-0abc123"
}

output "private_subnet_ids" {
  value = ["subnet-1", "subnet-2"]
}
