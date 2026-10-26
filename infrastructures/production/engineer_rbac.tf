

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


# ###############################
# ### engineer users config
# ###############################



resource "random_password" "federated_engineer1_initial_pass" {
  length  = 7
  special = false
}

resource "snowflake_user" "federated_engineer1" {
  name                 = "FEDERATED_ENGINEER1"
  default_warehouse    = snowflake_warehouse.lonestar_warehouse.name
  default_role         = snowflake_account_role.engineer_prod_role.name
  default_namespace    = snowflake_database.lonestar_prod_db.name
  display_name         = "engineer_taofeecoh"
  login_name           = "engtaofeecoh"
  password             = random_password.federated_engineer1_initial_pass.result
  must_change_password = true

  lifecycle {
    ignore_changes = [password, must_change_password]
  }
}


resource "snowflake_grant_account_role" "grant_engineer1" {
  role_name = snowflake_account_role.engineer_prod_role.name
  user_name = snowflake_user.federated_engineer1.name
}
