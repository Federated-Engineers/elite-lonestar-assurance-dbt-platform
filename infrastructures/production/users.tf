
module "federated_engineer1" {
  source = "../modules/snowflake_users"

  name              = "FEDERATED_ENGINEER1"
  default_warehouse = module.engineer_prod_warehouse.name
  default_role      = snowflake_account_role.engineer_prod_role.name
  default_namespace = snowflake_database.lonestar_prod_db.name
  display_name      = "engineer_taofeecoh"
  login_name        = "engtaofeecoh"
}

module "federated_analyst1" {
  source = "../modules/snowflake_users"

  name              = "FEDERATED_ANALYST1"
  default_warehouse = module.analyst_prod_warehouse.name
  default_role      = snowflake_account_role.analyst_prod_role.name
  default_namespace = snowflake_database.lonestar_prod_db.name
  display_name      = "analyst_taofeecoh"
  login_name        = "anataofeecoh"
}

