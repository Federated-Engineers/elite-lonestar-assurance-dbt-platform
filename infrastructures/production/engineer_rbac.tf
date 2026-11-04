

##################################
### engineer role  config
##################################

resource "snowflake_account_role" "engineer_prod_role" {
  name    = "ENGINEER_PROD_ROLE"
  comment = "role for engineer"
}


resource "snowflake_grant_account_role" "engineer_inherit_analyst" {
  role_name        = snowflake_account_role.analyst_prod_role.name
  parent_role_name = snowflake_account_role.engineer_prod_role.name
}



#################################################
### engineer role privileges config for schemas, integration
#################################################


resource "snowflake_grant_privileges_to_account_role" "engineer_prod_role_wh_grants" {
  account_role_name = snowflake_account_role.engineer_prod_role.name
  privileges        = ["USAGE"]
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = module.engineer_prod_warehouse.name
  }
}


resource "snowflake_grant_privileges_to_account_role" "engineer_role_integration_grants" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.engineer_prod_role.name
  on_account_object {
    object_type = "INTEGRATION"
    object_name = snowflake_storage_integration_aws.lonestar.name
  }
}


resource "snowflake_grant_privileges_to_account_role" "engineer_role_bronze_schema_grants" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_schema {
    schema_name = snowflake_schema.prod_bronze_schema.fully_qualified_name
  }

}



resource "snowflake_grant_privileges_to_account_role" "engineer_role_silver_schema_grants" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.engineer_prod_role.name
  on_schema {
    schema_name = snowflake_schema.prod_silver_schema.fully_qualified_name
  }
}


resource "snowflake_grant_privileges_to_account_role" "grant_silver_tables_all" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.engineer_prod_role.name
  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.prod_silver_schema.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "grant_silver_tables_future" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.engineer_prod_role.name
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.prod_silver_schema.fully_qualified_name
    }
  }
}



resource "snowflake_grant_privileges_to_account_role" "grant_silver_views_all" {
  privileges        = ["SELECT", "REFERENCES"]
  account_role_name = snowflake_account_role.engineer_prod_role.name
  on_schema_object {
    all {
      object_type_plural = "VIEWS"
      in_schema          = snowflake_schema.prod_silver_schema.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "grant_silver_views_future" {
  privileges        = ["SELECT", "REFERENCES"]
  account_role_name = snowflake_account_role.engineer_prod_role.name
  on_schema_object {
    future {
      object_type_plural = "VIEWS"
      in_schema          = snowflake_schema.prod_silver_schema.fully_qualified_name
    }
  }
}
