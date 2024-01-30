resource "kubernetes_service" "homeassistant" {
  metadata {
    name      = "home-assistant"
    namespace = kubernetes_namespace.home-automation.metadata[0].name
  }
  spec {
    selector = {
      app = kubernetes_deployment.homeassistant.metadata[0].labels.app
    }
    type = "ClusterIP"
    port {
      name        = "http"
      port        = 8123
      target_port = 8123
    }
  }
}

resource "kubernetes_deployment" "homeassistant" {
  metadata {
    name      = "home-assistant"
    namespace = kubernetes_namespace.home-automation.metadata[0].name
    labels = {
      "app" : "home-assistant"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        "app" : "home-assistant"
      }
    }
    template {
      metadata {
        labels = {
          "app" : "home-assistant"
        }
      }
      spec {
        container {
          name  = "home-assistant"
          image = "ghcr.io/home-assistant/home-assistant:${var.home_assistant_version}"

          port {
            container_port = 8123
          }

          resources {
            limits = {
              memory = "512Mi"
            }
            requests = {
              memory = "256Mi"
            }
          }
          security_context {
            privileged = true
            capabilities {
              add = ["NET_ADMIN", "NET_RAW", "SYS_ADMIN"]
            }
          }

          volume_mount {
            name       = "config"
            sub_path   = "homeassistant"
            mount_path = "/config"
          }
          volume_mount {
            mount_path = "/run/dbus"
            name       = "d-bus"
            read_only  = true
          }
        }
        host_network = true
        volume {
          name = "config"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.home-automation.metadata[0].name
          }
        }
        volume {
          name = "d-bus"
          host_path {
            path = "/run/dbus"
          }
        }
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "home-automation" {
  metadata {
    name      = "home-assistant-config"
    namespace = kubernetes_namespace.home-automation.metadata[0].name
    labels = {
      "app" = "home-assistant"
    }
  }

  spec {
    storage_class_name = kubernetes_storage_class.nfs.metadata[0].name
    access_modes       = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }

  }
}
