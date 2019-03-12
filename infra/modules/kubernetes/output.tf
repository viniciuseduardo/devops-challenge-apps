output "cluster_endpoint" {
  value = "${google_container_cluster.devops-challenger-k8s.endpoint}"
}

output "client_certificate" {
  value = "${google_container_cluster.devops-challenger-k8s.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.devops-challenger-k8s.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.devops-challenger-k8s.master_auth.0.cluster_ca_certificate}"
}