
output "analyst_test_password" {
  value     = nonsensitive(random_password.federated_analyst1_initial_pass.result)
  description = "one time login password for user; to be changed on first use"
}

output "engineer_test_password" {
  value     = nonsensitive(random_password.federated_engineer1_initial_pass.result)
  description = "one time login password for user; to be changed on first use"
}
