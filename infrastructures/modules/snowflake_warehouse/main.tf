
resource "snowflake_warehouse" "lonestar_warehouse" {
  name                      = local.name
  warehouse_type            = var.warehouse_type
  warehouse_size            = var.warehouse_size
  max_cluster_count         = var.max_cluster_count
  min_cluster_count         = var.min_cluster_count
  auto_suspend              = var.auto_suspend
  auto_resume               = var.auto_resume
  enable_query_acceleration = var.enable_query_acceleration
  initially_suspended       = true
}
