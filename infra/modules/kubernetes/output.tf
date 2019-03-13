output "cluster_endpoint" {
  value = "${google_container_cluster.devops-challenger-k8s.endpoint}"
}

output "cluster_user_pwd" {
  value = "${random_string.cluster-user-pwd.result}"
}
output "cluster_client_certificate" {
  value = "${base64decode(google_container_cluster.devops-challenger-k8s.master_auth.0.client_certificate)}"
}

output "cluster_client_key" {
  value = "${base64decode(google_container_cluster.devops-challenger-k8s.master_auth.0.client_key)}"
}

output "cluster_ca_certificate" {
  value = "${base64decode(google_container_cluster.devops-challenger-k8s.master_auth.0.cluster_ca_certificate)}"
}