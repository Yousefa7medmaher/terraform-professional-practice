variable "ingress" {
  type = list(object({
    port        = number
    cidr_blocks = list(string)
    description = optional(string, "managed by terraform")
  }))
  default = [
    { port = 80, cidr_blocks = ["0.0.0.0/0"] },
    { port = 443, cidr_blocks = ["0.0.0.0/0"] },
    { port = 22, cidr_blocks = ["10.0.0.0/8"], description = "ssh from VPN" },
  ]
}

variable "enable_egress" {
  type    = bool
  default = true
}

resource "aws_security_group" "web" {
  name        = "web-sg"
  description = "web"

  dynamic "ingress" {
    for_each = var.ingress
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  # Conditional nested block: 0 or 1 copies
  dynamic "egress" {
    for_each = var.enable_egress ? [1] : []
    content {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [tags]
  }
}

locals {
  ingress_rules = [for r in var.ingress : "${r.port}:${join(",", r.cidr_blocks)}"]
  public_ports  = [for r in var.ingress : r.port if contains(r.cidr_blocks, "0.0.0.0/0")]
}
