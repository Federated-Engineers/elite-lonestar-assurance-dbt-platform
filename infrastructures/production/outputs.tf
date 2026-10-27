
output "engineer_test_password" {
  value = module.federated_engineer1.user_initial_password
}


output "analyst_test_password" {
  value = module.federated_analyst1.user_initial_password
}
