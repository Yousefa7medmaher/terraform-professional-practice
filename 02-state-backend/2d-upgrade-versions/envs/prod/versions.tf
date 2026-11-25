terraform {
  required_version = "~> 1.14.0"
}

resource "terraform_data" "prod" {
  input = "prod"
}
