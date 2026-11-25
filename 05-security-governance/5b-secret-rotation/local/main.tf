terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.12"
    }
  }
}

variable "rotation_minutes" {
  type    = number
  default = 1
}

resource "time_rotating" "password" {
  rotation_minutes = var.rotation_minutes
}

resource "random_password" "app" {
  length = 24

  lifecycle {
    replace_triggered_by = [time_rotating.password]
  }
}

output "password_id" {
  value = random_password.app.id
}

output "next_rotation" {
  value = time_rotating.password.rotation_rfc3339
}
