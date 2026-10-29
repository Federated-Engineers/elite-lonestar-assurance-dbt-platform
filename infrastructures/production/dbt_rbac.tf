

##################################
### dbt user config
##################################


resource "snowflake_account_role" "dbt_prod_role" {
  name    = "DBT_PROD_ROLE"
  comment = "role for dbt service"
}


resource "snowflake_user" "dbt_service_user" {
  name              = "DBT_PROD_SERVICE_USER"
  default_warehouse = module.dbt_prod_warehouse.name
  default_role      = snowflake_account_role.dbt_prod_role.name
  default_namespace = snowflake_database.lonestar_prod_db.name
  rsa_public_key    = data.aws_ssm_parameter.dbt_public_key.value
}


resource "snowflake_grant_account_role" "grant_dbt_service_user" {
  role_name = snowflake_account_role.dbt_prod_role.name
  user_name = snowflake_user.dbt_service_user.name
}


####################################################
### dbt role privileges config for account objects
####################################################

resource "snowflake_grant_privileges_to_account_role" "dbt_wh_grants" {
  account_role_name = snowflake_account_role.dbt_prod_role.name
  privileges        = ["USAGE"]
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = module.dbt_prod_warehouse.name
  }
}


resource "snowflake_grant_privileges_to_account_role" "dbt_role_database_grants" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.lonestar_prod_db.name
  }
}


#################################################
### dbt role privileges config for bronze schema
#################################################

resource "snowflake_grant_privileges_to_account_role" "dbt_role_bronze_schema_grants" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_schema {
    schema_name = snowflake_schema.prod_bronze_schema.fully_qualified_name
  }

}


resource "snowflake_grant_privileges_to_account_role" "grant_future_bronze_tables" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.prod_bronze_schema.fully_qualified_name
    }
  }
}



#################################################
### dbt role privileges config for silver schema
#################################################


resource "snowflake_grant_privileges_to_account_role" "dbt_role_silver_schema_grants" {
  privileges        = ["USAGE", "CREATE TABLE", "CREATE VIEW", "CREATE MATERIALIZED VIEW", "CREATE PROCEDURE", "CREATE STAGE"]
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_schema {
    schema_name = snowflake_schema.prod_silver_schema.fully_qualified_name
  }
}


#################################################
### dbt role privileges config for gold schema
#################################################


resource "snowflake_grant_privileges_to_account_role" "dbt_role_gold_schema_grants" {
  privileges        = ["USAGE", "CREATE TABLE", "CREATE VIEW", "CREATE MATERIALIZED VIEW", "CREATE PROCEDURE", "CREATE STAGE"]
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_schema {
    schema_name = snowflake_schema.prod_gold_schema.fully_qualified_name
  }
}


#######################################################
### dbt role privileges config for elementary schema
#######################################################


resource "snowflake_grant_privileges_to_account_role" "dbt_role_elementary_schema_grants" {
  privileges        = ["USAGE", "CREATE TABLE"]
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_schema {
    schema_name = snowflake_schema.prod_elementary_schema.fully_qualified_name
  }
}
