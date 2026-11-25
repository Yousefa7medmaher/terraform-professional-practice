moved {
  from = random_pet.shop_name
  to   = module.shop.random_pet.name
}

moved {
  from = random_password.shop_secret
  to   = module.shop.random_password.secret
}

moved {
  from = terraform_data.shop_server
  to   = module.shop.terraform_data.server
}

moved {
  from = random_pet.blog_name
  to   = module.blog.random_pet.name
}

moved {
  from = random_password.blog_secret
  to   = module.blog.random_password.secret
}

moved {
  from = terraform_data.blog_server
  to   = module.blog.terraform_data.server
}
