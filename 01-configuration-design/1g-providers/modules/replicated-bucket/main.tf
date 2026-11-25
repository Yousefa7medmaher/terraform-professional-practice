terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 5.0"
      configuration_aliases = [aws.replica]
    }
  }
}

variable "name" {
  type = string
}

resource "aws_s3_bucket" "source" {
  bucket = var.name
}

resource "aws_s3_bucket" "replica" {
  provider = aws.replica
  bucket   = "${var.name}-replica"
}

output "bucket_arns" {
  value = [aws_s3_bucket.source.arn, aws_s3_bucket.replica.arn]
}
