terraform {
  required_version = ">= 1.10.0" # 1. fixed indentation (terraform fmt)
}

variable "names" {
  type    = list(string)
  default = ["a", "b"]
}

resource "terraform_data" "one" {
  input = var.names # 2. var.name_list was never declared
}

resource "terraform_data" "two" {
  count = length(var.names) # 3. count needs a number, not a list
  input = "x"
}

# 4. a <-> b was a cycle; b no longer depends on a
resource "terraform_data" "a" {
  input = terraform_data.b.output
}

resource "terraform_data" "b" {
  input = "base"
}
