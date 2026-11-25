variable "environment" {
  type    = string
  default = "dev"
}

variable "env_short" {
  type    = string
  default = "dev"
}

locals {
  # BUG HUNT: something is wrong in this file. Do not peek at solution/.
  instance_count = var.environment == "production" ? 3 : 1
}

resource "random_pet" "instance" {
  count  = local.instance_count
  prefix = "web-${var.env_short}-${count.index + 1}"
  length = 1
}

output "instance_names" {
  value = random_pet.instance[0].id
}
