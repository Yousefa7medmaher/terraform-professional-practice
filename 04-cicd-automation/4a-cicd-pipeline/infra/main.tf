terraform {
  required_version = ">= 1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket       = "CHANGE_ME-tfstate"
    key          = "cicd-demo/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_ssm_parameter" "demo" {
  name  = "/practice/cicd-demo"
  type  = "String"
  value = "deployed by GitHub Actions"
}
