
##################################
### analyst role config
##################################

resource "snowflake_account_role" "analyst_test_role" {
  name    = "ANALYST_TEST_ROLE"
  comment = "role for analyst"
}



####################################################
### analyst test role privileges config
####################################################

resource "snowflake_grant_privileges_to_account_role" "analyst_test_role_wh_grants" {
  account_role_name = snowflake_account_role.analyst_test_role.name
  privileges        = ["USAGE"]
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.test_warehouse.name
  }
}


resource "snowflake_grant_privileges_to_account_role" "analyst_test_role_database_grants" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.analyst_test_role.name
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.lonestar_test_db.name
  }
}


#################################################
### analyst role privileges config for gold schema
#################################################


resource "snowflake_grant_privileges_to_account_role" "analyst_role_gold_schema_grants" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.analyst_test_role.name
  on_schema {
    schema_name = snowflake_schema.test_gold_schema.fully_qualified_name
  }
}



resource "snowflake_grant_privileges_to_account_role" "grant_gold_tables_all" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.analyst_test_role.name
  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.test_gold_schema.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "grant_gold_tables_future" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.analyst_test_role.name
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.test_gold_schema.fully_qualified_name
    }
  }
}



resource "snowflake_grant_privileges_to_account_role" "grant_gold_views_all" {
  privileges        = ["SELECT", "REFERENCES"]
  account_role_name = snowflake_account_role.analyst_test_role.name
  on_schema_object {
    all {
      object_type_plural = "VIEWS"
      in_schema          = snowflake_schema.test_gold_schema.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "grant_gold_views_future" {
  privileges        = ["SELECT", "REFERENCES"]
  account_role_name = snowflake_account_role.analyst_test_role.name
  on_schema_object {
    future {
      object_type_plural = "VIEWS"
      in_schema          = snowflake_schema.test_gold_schema.fully_qualified_name
    }
  }
}



#######################################################
### analyst role privileges config for elementary schema
#######################################################


resource "snowflake_grant_privileges_to_account_role" "analyst_role_elementary_schema_grants" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.analyst_test_role.name
  on_schema {
    schema_name = snowflake_schema.test_elementary_schema.fully_qualified_name
  }
}


resource "snowflake_grant_privileges_to_account_role" "grant__tables_all" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.analyst_test_role.name
  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.test_elementary_schema.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "grant_elementary_tables_future" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.analyst_test_role.name
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.test_elementary_schema.fully_qualified_name
    }
  }
}


####################################################
### analyst users
####################################################

resource "snowflake_user" "analyst_test_user" {
  name              = "ANALYST_TEST_USER"
  default_warehouse = snowflake_warehouse.test_warehouse.name
  default_role      = snowflake_account_role.analyst_test_role.name
  default_namespace = snowflake_database.lonestar_test_db.name
}


resource "snowflake_grant_account_role" "grant_analyst_test_user" {
  role_name = snowflake_account_role.analyst_test_role.name
  user_name = snowflake_user.analyst_test_user.name
}
