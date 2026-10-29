
module "dbt_prod_warehouse" {
  source = "../modules/snowflake_warehouse"

  name           = "DBT"
  environment    = "PROD"
  warehouse_type = "STANDARD"
  warehouse_size = "XSMALL"
  auto_suspend   = 60

}


module "analyst_prod_warehouse" {
  source = "../modules/snowflake_warehouse"

  name           = "ANALYST"
  environment    = "PROD"
  warehouse_type = "STANDARD"
  warehouse_size = "XSMALL"
  auto_suspend   = 300

}


module "engineer_prod_warehouse" {
  source = "../modules/snowflake_warehouse"

  name           = "ENGINEER"
  environment    = "PROD"
  warehouse_type = "STANDARD"
  warehouse_size = "XSMALL"
  auto_suspend   = 300

}
