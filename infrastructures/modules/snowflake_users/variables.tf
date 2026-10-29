
variable "name" {
  type        = string
  description = "user's default database"
}


variable "default_warehouse" {
  type        = string
  description = "user's default warehouse"
}


variable "default_role" {
  type        = string
  description = "user's default role"
}


variable "default_namespace" {
  type        = string
  description = "user's default database"
}


variable "login_name" {
  type        = string
  description = "user's login name"
}


variable "display_name" {
  type        = string
  description = "user's display name"
  default     = null
}
