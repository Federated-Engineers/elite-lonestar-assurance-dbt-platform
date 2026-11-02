

resource "snowflake_storage_integration_aws" "lonestar" {
  name                      = "lonestar_aws_int"
  enabled                   = true
  storage_provider          = "S3"
  storage_allowed_locations = ["s3://lone-star-assurance-lake/"]
  storage_aws_role_arn      = "arn:aws:iam::049417293525:role/elite-snowflake-role"
}
