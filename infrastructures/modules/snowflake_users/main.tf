
terraform {
  required_providers {
    snowflake = {
      source = "snowflakedb/snowflake"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}


resource "random_password" "user_initial_pass" {
  length  = 7
  special = false
}


resource "snowflake_user" "user" {
  name                 = var.name
  default_warehouse    = var.default_warehouse
  default_role         = var.default_role
  default_namespace    = var.default_namespace
  login_name           = var.login_name
  display_name         = var.display_name
  password             = random_password.user_initial_pass.result
  must_change_password = true

  lifecycle {
    ignore_changes = [password, must_change_password]
  }

}


resource "snowflake_grant_account_role" "grant_user" {
  role_name = var.default_role
  user_name = snowflake_user.user.name
}
