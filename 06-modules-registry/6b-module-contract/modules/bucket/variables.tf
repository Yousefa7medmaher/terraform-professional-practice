variable "name" {
  type        = string
  description = "Bucket name (lowercase)."

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.name))
    error_message = "name must be lowercase letters, numbers and dashes."
  }
}

variable "lifecycle_days" {
  type     = number
  default  = 30
  nullable = false
}

variable "config" {
  type = object({
    versioning = optional(bool, true)
    tier       = optional(string, "hot")
    tags       = optional(map(string), {})
  })
  default = {}
}
