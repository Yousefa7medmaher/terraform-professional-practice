output "summary" {
  description = "Everything a caller may rely on."
  value = {
    name       = var.name
    path       = local_file.bucket.filename
    versioning = var.config.versioning
    tier       = var.config.tier
  }
}
