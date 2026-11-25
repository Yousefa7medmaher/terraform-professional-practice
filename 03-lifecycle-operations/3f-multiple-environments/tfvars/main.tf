variable "environment" {
  type = string
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "instance_size" {
  type    = string
  default = "small"
}

resource "terraform_data" "server" {
  count = var.instance_count
  input = "${var.environment}-${var.instance_size}-${count.index}"
}

output "servers" {
  value = terraform_data.server[*].output
}
