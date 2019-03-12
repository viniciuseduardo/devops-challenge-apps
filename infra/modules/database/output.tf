output "database_connection_name" {
  value = "${google_sql_database_instance.devops-challenge-database.connection_name}"
}

output "database_private_ip" {
  value = "${google_sql_database_instance.devops-challenge-database.private_ip_address}"
}

output "database_public_ip" {
  value = "${google_sql_database_instance.devops-challenge-database.public_ip_address}"
}