terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }
}

module "shop" {
  source = "./modules/web-app"
  name   = "shop"
}

module "blog" {
  source = "./modules/web-app"
  name   = "blog"
}
