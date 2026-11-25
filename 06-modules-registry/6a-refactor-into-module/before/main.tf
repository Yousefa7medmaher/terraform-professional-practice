terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }
}

# --- app "shop" ---
resource "random_pet" "shop_name" {
  prefix = "shop"
}

resource "random_password" "shop_secret" {
  length = 16
}

resource "terraform_data" "shop_server" {
  input = random_pet.shop_name.id
}

# --- app "blog" (copy-paste!) ---
resource "random_pet" "blog_name" {
  prefix = "blog"
}

resource "random_password" "blog_secret" {
  length = 16
}

resource "terraform_data" "blog_server" {
  input = random_pet.blog_name.id
}
