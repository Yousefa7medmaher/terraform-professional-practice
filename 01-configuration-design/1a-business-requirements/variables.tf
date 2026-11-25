variable "environments" {
  description = "Environments every team gets storage in."
  type        = set(string)
  default     = ["dev", "prod"]

  validation {
    condition     = alltrue([for e in var.environments : contains(["dev", "stage", "prod"], e)])
    error_message = "Environments must be one of: dev, stage, prod."
  }
}

variable "teams" {
  description = "Teams and their metadata."
  type = map(object({
    cost_center = string
    owner_email = string
  }))

  default = {
    platform = { cost_center = "CC-100", owner_email = "platform@example.com" }
    payments = { cost_center = "CC-200", owner_email = "payments@example.com" }
  }

  validation {
    condition     = alltrue([for t in values(var.teams) : startswith(t.cost_center, "CC-")])
    error_message = "Every team's cost_center must start with \"CC-\"."
  }
}
