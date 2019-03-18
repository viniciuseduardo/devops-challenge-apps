output "web_url" {
  value = "http://${kubernetes_service.devops-challenge-web-service.load_balancer_ingress.0.ip}:${kubernetes_service.devops-challenge-web-service.spec.0.port.0.port}"
}
