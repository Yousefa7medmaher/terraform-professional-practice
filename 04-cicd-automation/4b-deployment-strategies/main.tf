terraform {
  required_version = ">= 1.10.0"
}

variable "environment" {
  type    = string
  default = "local"
}

variable "release" {
  type    = string
  default = "v1"
}

resource "terraform_data" "app" {
  input = "${var.environment}-${var.release}"

  triggers_replace = [var.release]

  lifecycle {
    create_before_destroy = true
  }
}

output "live" {
  value = terraform_data.app.output
}
