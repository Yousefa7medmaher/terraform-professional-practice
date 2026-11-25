output "storage_names" {
  description = "Name of every storage area, keyed by team-env."
  value       = { for k, m in module.storage : k => m.name }
}

output "versioned_areas" {
  description = "Only the storage areas that have versioning enabled."
  value       = [for k, m in module.storage : k if m.versioning]
}
