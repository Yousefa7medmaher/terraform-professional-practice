resource "local_file" "config" {
  filename = "${path.module}/out/config.txt"
  content  = "max_connections=100"
}
