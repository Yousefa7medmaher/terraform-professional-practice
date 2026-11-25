# Unit tests: plan only, but the aws provider is mocked so no credentials are needed.
mock_provider "aws" {}

variables {
  name = "practice"
}

run "dev_name_and_no_versioning" {
  command = plan

  assert {
    condition     = aws_s3_bucket.this.bucket == "practice-dev"
    error_message = "Bucket name should be <name>-<env>."
  }

  assert {
    condition     = output.versioning == false
    error_message = "Dev must not enable versioning."
  }
}

run "prod_enables_versioning" {
  command = plan

  variables {
    environment = "prod"
  }

  assert {
    condition     = output.versioning == true
    error_message = "Prod must enable versioning."
  }
}

run "rejects_bad_name" {
  command = plan

  variables {
    name = "Bad Name!"
  }

  expect_failures = [var.name]
}
