terraform {
  required_version = ">= 1.10.0"
}

variable "db_engine_version" {
  type    = string
  default = "15"
}

variable "allowed_cidr" {
  type    = string
  default = "10.0.0.0/8"
}

resource "terraform_data" "database" {
  # Changing the version replaces this "database" -> risky!
  triggers_replace = [var.db_engine_version]
  input            = "postgres-${var.db_engine_version}"

  lifecycle {
    # prevent_destroy = true
  }
}

resource "terraform_data" "firewall_rule" {
  input = var.allowed_cidr

  lifecycle {
    precondition {
      condition     = var.allowed_cidr != "0.0.0.0/0"
      error_message = "Opening the firewall to the whole internet is not allowed."
    }
  }
}
