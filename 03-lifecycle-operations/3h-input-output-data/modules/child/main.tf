variable "owner" {
  type = string
}

variable "replicas" {
  type = number
}

resource "terraform_data" "replica" {
  count = var.replicas
  input = "${var.owner}-${count.index}"
}

output "summary" {
  value = {
    owner    = var.owner
    replicas = terraform_data.replica[*].output
  }
}
