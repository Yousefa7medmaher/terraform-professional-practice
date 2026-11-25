terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Default provider (no alias)
provider "aws" {
  region = "us-east-1"
}

# Aliased provider for a second region
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

# Another account via assume_role
provider "aws" {
  alias  = "security"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::111111111111:role/terraform"
  }
}
