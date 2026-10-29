
##################################
### analyst role config
##################################

resource "snowflake_account_role" "analyst_prod_role" {
  name    = "ANALYST_PROD_ROLE"
  comment = "role for analyst"
}



####################################################
### analyst test role privileges config
####################################################

resource "snowflake_grant_privileges_to_account_role" "analyst_prod_role_wh_grants" {
  account_role_name = snowflake_account_role.analyst_prod_role.name
  privileges        = ["USAGE"]
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = module.analyst_prod_warehouse.name
  }
}


resource "snowflake_grant_privileges_to_account_role" "analyst_prod_role_database_grants" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.analyst_prod_role.name
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.lonestar_prod_db.name
  }
}


#################################################
### analyst role privileges config for gold schema
#################################################


resource "snowflake_grant_privileges_to_account_role" "analyst_role_gold_schema_grants" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.analyst_prod_role.name
  on_schema {
    schema_name = snowflake_schema.prod_gold_schema.fully_qualified_name
  }
}



resource "snowflake_grant_privileges_to_account_role" "grant_gold_tables_all" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.analyst_prod_role.name
  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.prod_gold_schema.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "grant_gold_tables_future" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.analyst_prod_role.name
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.prod_gold_schema.fully_qualified_name
    }
  }
}



resource "snowflake_grant_privileges_to_account_role" "grant_gold_views_all" {
  privileges        = ["SELECT", "REFERENCES"]
  account_role_name = snowflake_account_role.analyst_prod_role.name
  on_schema_object {
    all {
      object_type_plural = "VIEWS"
      in_schema          = snowflake_schema.prod_gold_schema.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "grant_gold_views_future" {
  privileges        = ["SELECT", "REFERENCES"]
  account_role_name = snowflake_account_role.analyst_prod_role.name
  on_schema_object {
    future {
      object_type_plural = "VIEWS"
      in_schema          = snowflake_schema.prod_gold_schema.fully_qualified_name
    }
  }
}



#######################################################
### analyst role privileges config for elementary schema
#######################################################


resource "snowflake_grant_privileges_to_account_role" "analyst_role_elementary_schema_grants" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.analyst_prod_role.name
  on_schema {
    schema_name = snowflake_schema.prod_elementary_schema.fully_qualified_name
  }
}


resource "snowflake_grant_privileges_to_account_role" "grant__tables_all" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.analyst_prod_role.name
  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.prod_elementary_schema.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "grant_elementary_tables_future" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.analyst_prod_role.name
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.prod_elementary_schema.fully_qualified_name
    }
  }
}
