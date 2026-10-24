terraform {
  backend "s3" {
    bucket = "lonestar-assurance-tfstate"
    key    = "production/lonestar-assurance/terraform.tfstate"
    region = "eu-central-1"
  }
}
