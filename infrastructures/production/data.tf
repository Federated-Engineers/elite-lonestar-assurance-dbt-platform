
data "aws_ssm_parameter" "dbt_public_key" {
  name = "/production/elite/snowflake/lonestar-assurance/dbt-public-key"
}
