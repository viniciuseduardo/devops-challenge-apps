output "database_connection_string" {
  value = "postgres://${var.database_user_name}:${random_string.database-user-pwd.result}@${google_sql_database_instance.devops-challenge-instance.public_ip_address}:5432/${var.database_server_name}"
}