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
    namespace = "devops-challenge-api-stack"
  }

  data {
    database_connection_string = "${var.database_connection_string}"
  }
}