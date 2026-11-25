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

variable "github_repo" {
  type        = string
  description = "owner/repo allowed to assume the role"
}

variable "hcp_org" {
  type = string
}

variable "hcp_project" {
  type    = string
  default = "Default Project"
}

variable "hcp_workspace" {
  type    = string
  default = "*"
}

# ---------- GitHub Actions ----------
resource "aws_iam_openid_connect_provider" "github" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
}

data "aws_iam_policy_document" "github_trust" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_repo}:*"]
    }
  }
}

resource "aws_iam_role" "github" {
  name               = "github-actions-terraform"
  assume_role_policy = data.aws_iam_policy_document.github_trust.json
}

# ---------- HCP Terraform ----------
resource "aws_iam_openid_connect_provider" "hcp" {
  url            = "https://app.terraform.io"
  client_id_list = ["aws.workload.identity"]
}

data "aws_iam_policy_document" "hcp_trust" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.hcp.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "app.terraform.io:aud"
      values   = ["aws.workload.identity"]
    }
    condition {
      test     = "StringLike"
      variable = "app.terraform.io:sub"
      values   = ["organization:${var.hcp_org}:project:${var.hcp_project}:workspace:${var.hcp_workspace}:run_phase:*"]
    }
  }
}

resource "aws_iam_role" "hcp" {
  name               = "hcp-terraform-dynamic-creds"
  assume_role_policy = data.aws_iam_policy_document.hcp_trust.json
}

# Least privilege for the lab: read-only
resource "aws_iam_role_policy_attachment" "github_ro" {
  role       = aws_iam_role.github.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "hcp_ro" {
  role       = aws_iam_role.hcp.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

output "github_role_arn" {
  value = aws_iam_role.github.arn
}

output "hcp_role_arn" {
  value = aws_iam_role.hcp.arn
}
