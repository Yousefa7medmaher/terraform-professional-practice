terraform {
  required_version = ">= 1.10.0"

  # Step 2: uncomment, then run: terraform init -backend-config=backend-dev.hcl -migrate-state
  # backend "s3" {}
}

resource "terraform_data" "app" {
  input = "my app"
}
