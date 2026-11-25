terraform {
  required_version = ">= 1.11.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "password_version" {
  type    = number
  default = 1 # bump to rotate
}

ephemeral "random_password" "db" {
  length           = 20
  override_special = "!#$%^&*()-_=+"
}

resource "aws_db_instance" "this" {
  identifier          = "practice-db"
  engine              = "postgres"
  instance_class      = "db.t4g.micro"
  allocated_storage   = 20
  username            = "app"
  skip_final_snapshot = true

  # write-only: sent to AWS, never written to state
  password_wo         = ephemeral.random_password.db.result
  password_wo_version = var.password_version
}

# Better: let AWS manage and rotate the master password in Secrets Manager
# manage_master_user_password = true
