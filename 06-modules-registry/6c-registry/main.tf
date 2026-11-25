terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.region
}

variable "region" {
  type    = string
  default = "us-east-1"
}

module "assets" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 5.0"

  bucket = "yousef-practice-assets"

  versioning = {
    enabled = true
  }
}

output "bucket_arn" {
  value = module.assets.s3_bucket_arn
}

# Private registry example (needs `terraform login`):
# module "bucket" {
#   source  = "app.terraform.io/YOUR_ORG/bucket/local"
#   version = "~> 1.0"
#   name    = "from-private-registry"
# }
