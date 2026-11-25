terraform {
required_version = ">= 1.10.0"
}

variable "names" {
  type    = list(string)
  default = ["a", "b"]
}

resource "terraform_data" "one" {
  input = var.name_list
}

resource "terraform_data" "two" {
  count = var.names
  input = "x"
}

resource "terraform_data" "a" {
  input = terraform_data.b.output
}

resource "terraform_data" "b" {
  input = terraform_data.a.output
}
