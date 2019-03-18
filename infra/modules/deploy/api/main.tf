resource "kubernetes_namespace" "devops-challenge-api-ns" {
  metadata {
    annotations {
      name = "devops-challenge-api-stack"
    }

    name = "devops-challenge-api-stack"
  }
}

resource "kubernetes_secret" "devops-challenge-api-secret" {
  metadata {
    name = "devops-challenge-api-secret"
    namespace = "${kubernetes_namespace.devops-challenge-api-ns.metadata.0.name}"
  }

  data {
    DB = "${var.database_connection_string}"
  }
}

resource "kubernetes_config_map" "devops-challenge-api-config" {
  metadata {
    name = "devops-challenge-api-config"
    namespace = "${kubernetes_namespace.devops-challenge-api-ns.metadata.0.name}"
  }

  data {
    PORT     = "${var.api_port}"
  }
}

resource "kubernetes_deployment" "devops-challenge-api-app" {
  "metadata" {
    name = "devops-challenge-api-app"
    namespace = "${kubernetes_namespace.devops-challenge-api-ns.metadata.0.name}"
    labels {
      app = "api"
    }
  }

  "spec" {
    replicas = 3

    selector {
      match_labels {
        app = "api"
      }
    }

    "template" {
      "metadata" {
        name = "devops-challenge-api-app"
        namespace = "${kubernetes_namespace.devops-challenge-api-ns.metadata.0.name}"
        labels {
          app = "api"
        }
      }     
      spec { 
        container {
          name = "api"
          image = "viniciuseduardorj/devops-challenge-api:latest"
          env_from{
            config_map_ref{ name = "${kubernetes_config_map.devops-challenge-api-config.metadata.0.name}" }
          }
          env_from{
            secret_ref{ name = "${kubernetes_secret.devops-challenge-api-secret.metadata.0.name}" }
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
            container_port = "${var.api_port}"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "devops-challenge-api-service" {
  "metadata" {
    name = "devops-challenge-api-app"
    namespace = "${kubernetes_namespace.devops-challenge-api-ns.metadata.0.name}"
    labels {
      app = "api"
    }
  }
  spec {
    selector {
      app = "${kubernetes_deployment.devops-challenge-api-app.metadata.0.labels.app}"
    }
    session_affinity = "ClientIP"
    port {
      port = "${var.api_port}"
      target_port = "${var.api_port}"
    }

    type = "LoadBalancer"
  }
}