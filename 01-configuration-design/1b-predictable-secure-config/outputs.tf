output "server_name" {
  value = random_pet.server.id
}

output "db_password" {
  value     = random_password.db.result
  sensitive = true # remove this line and run plan to see the error
}
