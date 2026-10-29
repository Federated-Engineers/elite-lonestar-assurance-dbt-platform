
terraform {
  required_providers {
    snowflake = {
      source = "snowflakedb/snowflake"
      version = "~> 2.22"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.9"
    }
  }
}
