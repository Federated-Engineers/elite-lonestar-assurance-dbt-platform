terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "~> 2.22"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.9"
    }

  }
}

provider "aws" {
  region = "eu-central-1"
}


#  primary role for terraform service user

provider "snowflake" {
  organization_name = local.organization_name
  account_name      = local.account_name
  user              = "TERRAFORM_SERVICE"
  role              = "TERRAFORM_ROLE"
  authenticator     = "SNOWFLAKE_JWT"
}

