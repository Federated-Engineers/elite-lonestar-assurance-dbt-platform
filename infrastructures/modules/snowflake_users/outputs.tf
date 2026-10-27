
output "user_initial_password" {
  value       = nonsensitive(random_password.user_initial_pass.result)
  description = "one time login password for user; to be changed on first use"
}
