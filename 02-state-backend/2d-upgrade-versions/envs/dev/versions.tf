terraform {
  required_version = "~> 1.14.0"
}

resource "terraform_data" "dev" {
  input = "dev"
}
