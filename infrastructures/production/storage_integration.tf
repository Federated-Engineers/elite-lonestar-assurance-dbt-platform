
resource "snowflake_storage_integration_aws" "lonestar" {
  name                      = "LONESTAR_AWS_INT"
  enabled                   = true
  storage_provider          = "S3"
  storage_allowed_locations = ["s3://lone-star-assurance-lake/"]
  storage_aws_role_arn      = "arn:aws:iam::049417293525:role/elite-snowflake-role"
}


resource "snowflake_file_format_json" "lonestar" {
  database = snowflake_database.lonestar_prod_db.name
  schema   = snowflake_schema.prod_bronze_schema.name
  name     = "LONESTAR_JSON_FILES"
}


resource "snowflake_stage_external_s3" "lonestar" {
  name                = "LONESTAR_EXTERNALS3_STAGE"
  database            = snowflake_database.lonestar_prod_db.name
  schema              = snowflake_schema.prod_bronze_schema.name
  url                 = "s3://lone-star-assurance-lake/"
  storage_integration = snowflake_storage_integration_aws.lonestar.name

  file_format {
    format_name = snowflake_file_format_json.lonestar.fully_qualified_name
  }

}
