variable "name" {
  type = string
}

variable "cidr" {
  type = string
}

resource "terraform_data" "vpc" {
  input = { name = var.name, cidr = var.cidr }
}

output "vpc_id" {
  value = "vpc-${md5(var.name)}"
}

output "subnets" {
  value = [for i in range(2) : cidrsubnet(var.cidr, 8, i)]
}
