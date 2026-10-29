
variable "name" {
  type = string
}

variable "warehouse_type" {
  type = string
  default = "standard"
}

variable "warehouse_size" {
  type = string
  default = "xsmall"
}

variable "max_cluster_count" {
  type = number
  default = 1
}

variable "min_cluster_count" {
  type = number
  default = 1
}

variable "auto_suspend" {
  type = number
  default = 60
}

variable "auto_resume" {
  type = bool
  default = true
}

variable "enable_query_acceleration" {
  type = bool
  default = false
}

variable "environment" {
  type = string
}
