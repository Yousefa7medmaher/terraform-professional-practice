module "logs" {
  source = "./modules/bucket"
  name   = "logs"
  config = {
    versioning = false
  }
}

module "data" {
  source         = "./modules/bucket"
  name           = "data"
  lifecycle_days = 90
  config = {
    tier = "cold"
  }
}

module "optional_backup" {
  source = "./modules/bucket"
  count  = var.enable_backup ? 1 : 0
  name   = "backup"
}

variable "enable_backup" {
  type    = bool
  default = true
}

output "buckets" {
  value = {
    logs   = module.logs.summary
    data   = module.data.summary
    backup = one(module.optional_backup[*].summary)
  }
}
