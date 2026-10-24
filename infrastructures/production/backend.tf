terraform {
  backend "s3" {
    bucket = "federated-engineers-production-elite-lonestar-assurance-tfstate"
    key    = "production/lonestar-assurance/terraform.tfstate"
    region = "eu-central-1"
  }
}
