terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

variable "name" {
  type = string

  validation {
    condition     = can(regex("^[a-z0-9-]{3,40}$", var.name))
    error_message = "name must be 3-40 chars of lowercase letters, numbers or dashes."
  }
}

variable "environment" {
  type    = string
  default = "dev"
}

locals {
  bucket_name = "${var.name}-${var.environment}"
  versioning  = var.environment == "prod"
}

resource "aws_s3_bucket" "this" {
  bucket = local.bucket_name
  tags = {
    environment = var.environment
  }
}

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}

output "versioning" {
  value = local.versioning
}

output "arn" {
  value = aws_s3_bucket.this.arn
}
