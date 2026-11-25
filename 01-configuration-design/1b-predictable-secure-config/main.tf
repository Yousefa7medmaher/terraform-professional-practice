# Step 1 of the lab: rename this to random_pet.app_server
resource "random_pet" "server" {
  length = 2
}

resource "random_password" "db" {
  length  = 20
  special = true
}
