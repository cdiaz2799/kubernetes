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
          volume_mount {
            name       = "eufy-config"
            mount_path = "/config"
            sub_path   = "eufy"
          }
          env {
            name  = "COUNTRY"
            value = "US"
          }
          env_from {
            secret_ref {
              name = kubernetes_secret.eufy_creds.metadata[0].name
            }
          }
        }
        restart_policy = "Always"
        host_network   = true
        volume {
          name = "eufy-config"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.home-automation.metadata[0].name
          }
        }
      }
    }
  }
  depends_on = [kubernetes_secret.eufy_creds]
}

resource "kubernetes_secret" "eufy_creds" {
  metadata {
    name      = "eufy"
    namespace = kubernetes_namespace.home-automation.metadata[0].name
  }
  data = {
    "USERNAME" = data.onepassword_item.eufy_creds.username
    "PASSWORD" = data.onepassword_item.eufy_creds.password
  }

}
data "onepassword_item" "eufy_creds" {
  vault = var.op_vault
  title = "Eufy"
}
