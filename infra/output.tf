output "cluster_endpoint" {
  value = "https://${module.devops-challenge-k8s.cluster_endpoint}"
}

output "database_connection_string" {
  value = "${module.devops-challenge-database.database_connection_string}"
}