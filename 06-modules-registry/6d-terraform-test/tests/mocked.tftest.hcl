# "apply" against a mocked provider: computed values (like arn) come from the mock.
mock_provider "aws" {
  mock_resource "aws_s3_bucket" {
    defaults = {
      arn = "arn:aws:s3:::mocked-bucket"
    }
  }
}

variables {
  name = "practice"
}

run "apply_with_mock" {
  # command defaults to apply

  assert {
    condition     = output.arn == "arn:aws:s3:::mocked-bucket"
    error_message = "ARN should come from the mock."
  }
}

run "override_one_resource" {
  override_resource {
    target = aws_s3_bucket.this
    values = {
      arn = "arn:aws:s3:::overridden"
    }
  }

  assert {
    condition     = output.arn == "arn:aws:s3:::overridden"
    error_message = "override_resource should win."
  }
}
