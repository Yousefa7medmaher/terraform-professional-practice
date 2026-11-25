variable "color" {
  type    = string
  default = "default"
}

output "color" {
  value = var.color
}
