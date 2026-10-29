

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
### engineer role privileges config for silver schema
#################################################


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
