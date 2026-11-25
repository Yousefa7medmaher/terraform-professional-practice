terraform {
  cloud {
    organization = "YOUR_ORG"

    workspaces {
      name = "cli-driven-demo"
    }
  }
}

resource "terraform_data" "hello" {
  input = "hello from HCP Terraform"
}

check "always_ok" {
  assert {
    condition     = terraform_data.hello.output != ""
    error_message = "Output should not be empty."
  }
}

output "hello" {
  value = terraform_data.hello.output
}
