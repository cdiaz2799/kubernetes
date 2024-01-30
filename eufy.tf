resource "kubernetes_service" "eufy" {
  metadata {
    name      = "eufy-security"
    namespace = kubernetes_namespace.home-automation.metadata[0].name
    labels = {
      "app" : "eufy-security"
    }
  }

  spec {
    type     = "ClusterIP"
    selector = kubernetes_deployment.eufy.metadata[0].labels
    port {
      port        = 3000
      target_port = 3000
    }
  }
}

resource "kubernetes_deployment" "eufy" {
  metadata {
    name      = "eufy-security"
    namespace = kubernetes_namespace.home-automation.metadata[0].name
    labels = {
      "app" : "eufy-security"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        "app" : "eufy-security"
      }
    }
    template {
      metadata {
        labels = {
          "app" : "eufy-security"
        }
      }
      spec {
        container {
          name  = "eufy-security"
          image = "bropat/eufy-security-ws:latest"
          port {
            container_port = 3000
          }
        }
        restart_policy = "Always"
        volume {
          name = "eufy-config"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.eufy.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_secret" "eufy-creds" {
  metadata {
    name      = "eufy-creds"
    namespace = kubernetes_namespace.home-automation.metadata[0].name
    labels = {
      "app" = "eufy-security"
    }
  }
  data = {
    "USERNAME" : var.eufy_username
    "PASSWORD" : var.eufy_password
  }
}

resource "kubernetes_persistent_volume_claim" "eufy" {
  metadata {
    name      = "eufy-security-data"
    namespace = kubernetes_namespace.home-automation.metadata[0].name
    labels = {
      "app" = "eufy-security"
    }
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "10Mi"
      }
    }

  }
}
