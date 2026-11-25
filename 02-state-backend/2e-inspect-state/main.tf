resource "random_pet" "count_pet" {
  count = 3
}

module "app" {
  source = "./modules/app"
  keys   = ["api", "worker"]
}

output "pets" {
  value = random_pet.count_pet[*].id
}
