variable "name" {
  type = string
}

variable "subnets" {
  type = list(string)
}

resource "terraform_data" "app" {
  for_each = toset(var.subnets)
  input    = "${var.name} in ${each.value}"
}

output "instances" {
  value = [for i in terraform_data.app : i.output]
}
