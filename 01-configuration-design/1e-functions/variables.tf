variable "tags" {
  type = map(string)
  default = {
    Department  = "Platform"
    Environment = "Development"
  }
}

variable "extra_tags" {
  type = map(string)
  default = {
    Environment = "Production"
    Owner       = "yousef"
  }
}

variable "ports" {
  type    = list(number)
  default = [80, 443, 8080, 443]
}

variable "names" {
  type    = list(string)
  default = ["  Web ", "API", "", "db"]
}

variable "nested" {
  type    = list(list(string))
  default = [["a", "b"], [], ["c"]]
}

variable "config" {
  type = any
  default = {
    db = { port = 5432 }
  }
}
