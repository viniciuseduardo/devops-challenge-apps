output "cluster_endpoint" {
  value = "https://${module.devops-challenge-k8s.cluster_endpoint}"
}

output "api_url" {
  value = "${module.devops-challenge-deploy-api.api_url}"
}

output "web_url" {
  value = "${module.devops-challenge-deploy-web.web_url}"
}