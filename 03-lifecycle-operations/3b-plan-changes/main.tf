variable "length" {
  type    = number
  default = 2
}

resource "random_pet" "a" {
  length = var.length # changing length forces replacement
}

resource "random_pet" "b" {}

data "local_file" "readme" {
  filename = "${path.module}/README.md"
}

output "readme_size" {
  value = length(data.local_file.readme.content)
}
