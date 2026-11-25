terraform {
  required_version = ">= 1.10.0"
}

resource "terraform_data" "server" {
  input = "web-1"
}

resource "terraform_data" "notify" {
  triggers_replace = [terraform_data.server.id]

  provisioner "local-exec" {
    command = "echo 'server ${terraform_data.server.output} created' >> deploy.log"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'destroying' >> deploy.log"
  }
}
