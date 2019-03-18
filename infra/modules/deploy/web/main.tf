resource "kubernetes_namespace" "devops-challenge-web-ns" {
  metadata {
    annotations {
      name = "devops-challenge-web-stack"
    }

    name = "devops-challenge-web-stack"
  }
}

resource "kubernetes_config_map" "devops-challenge-web-config" {
  metadata {
    name = "devops-challenge-web-config"
    namespace = "${kubernetes_namespace.devops-challenge-web-ns.metadata.0.name}"
  }

  data {
    PORT     = "${var.app_port}"
    API_HOST = "${var.api_host}"
  }
}

resource "kubernetes_deployment" "devops-challenge-web-app" {
  "metadata" {
    name = "devops-challenge-web-app"
    namespace = "${kubernetes_namespace.devops-challenge-web-ns.metadata.0.name}"
    labels {
      app = "web"
    }
  }

  "spec" {
    replicas = 3

    selector {
      match_labels {
        app = "web"
      }
    }

    "template" {
      "metadata" {
        name = "devops-challenge-web-app"
        namespace = "${kubernetes_namespace.devops-challenge-web-ns.metadata.0.name}"
        labels {
          app = "web"
        }
      }     
      spec { 
        container {
          name = "web"
          image = "viniciuseduardorj/devops-challenge-web:latest"
          env_from{
            config_map_ref{ name = "${kubernetes_config_map.devops-challenge-web-config.metadata.0.name}" }
          }
          resources{
            limits{
              cpu    = "0.1"
              memory = "128Mi"
            }
            requests{
              cpu    = "100m"
              memory = "16Mi"
            }
          }
          port {
            container_port = "${var.app_port}"
          }

          liveness_probe{
            http_get {
              path = "/" 
              port="${var.app_port}"
            } 
            success_threshold = 1
            failure_threshold = 5
            period_seconds = 30
            timeout_seconds = 10
          }
          readiness_probe{
            http_get {
              path = "/" 
              port="${var.app_port}"
            } 
            success_threshold = 1
            failure_threshold = 5
            period_seconds = 30
            timeout_seconds = 10
          }          
        }
      }
    }
  }
}

resource "kubernetes_service" "devops-challenge-web-service" {
  "metadata" {
    name = "devops-challenge-web-app"
    namespace = "${kubernetes_namespace.devops-challenge-web-ns.metadata.0.name}"
    labels {
      app = "web"
    }
  }
  spec {
    selector {
      app = "${kubernetes_deployment.devops-challenge-web-app.metadata.0.labels.app}"
    }
    session_affinity = "ClientIP"
    port {
      port = "${var.app_port}"
      target_port = "${var.app_port}"
    }

    type = "LoadBalancer"
  }
}