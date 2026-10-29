

resource "snowflake_database" "lonestar_prod_db" {
  name         = "LONESTAR_PROD_DATABASE"
  is_transient = false
}


resource "snowflake_schema" "prod_bronze_schema" {
  name                = "BRONZE"
  database            = snowflake_database.lonestar_prod_db.name
  with_managed_access = false
}

resource "snowflake_schema" "prod_silver_schema" {
  name                = "SILVER"
  database            = snowflake_database.lonestar_prod_db.name
  with_managed_access = false
}

resource "snowflake_schema" "prod_gold_schema" {
  name                = "GOLD"
  database            = snowflake_database.lonestar_prod_db.name
  with_managed_access = false
}

resource "snowflake_schema" "prod_elementary_schema" {
  name                = "ELEMENTARY"
  database            = snowflake_database.lonestar_prod_db.name
  with_managed_access = false
}
