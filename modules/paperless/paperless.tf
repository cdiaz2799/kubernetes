resource "kubernetes_service" "paperless" {
  metadata {
    name      = "paperless"
    namespace = kubernetes_namespace.paperless.metadata[0].name
    labels = {
      app       = "paperless"
      component = "web"
    }
  }
  spec {
    selector = {
      "app"       = "paperless"
      "component" = "web"
    }
    port {
      port        = var.paperless_port
      target_port = 8000
    }
  }
}

resource "kubernetes_deployment" "paperless" {
  metadata {
    name      = "paperless"
    namespace = kubernetes_namespace.paperless.metadata[0].name
    labels = {
      app       = "paperless"
      component = "web"
    }
  }
  spec {
    replicas = "1"
    selector {
      match_labels = {
        "app"       = "paperless"
        "component" = "web"
      }
    }
    template {
      metadata {
        labels = {
          "app"       = "paperless"
          "component" = "web"
        }
      }
      spec {
        container {
          name  = "paperless"
          image = "ghcr.io/paperless-ngx/paperless-ngx:latest"
          port {
            container_port = 8000
            host_port      = 8000
          }

          liveness_probe {
            http_get {
              port = 8000
            }
            initial_delay_seconds = 60
            timeout_seconds       = 10
            period_seconds        = 30
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.postgresql.metadata[0].name
            }
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.paperless-redis.metadata[0].name
            }
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.paperless-tika.metadata[0].name
            }
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.paperless.metadata[0].name
            }
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.postgres-db.metadata[0].name
            }
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.smtp_creds.metadata[0].name
            }
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.paperless.metadata[0].name
            }
          }
          volume_mount {
            name       = "paperless"
            mount_path = "/usr/src/paperless/data"
            sub_path   = "data"
          }
          volume_mount {
            name       = "paperless"
            mount_path = "/usr/src/paperless/media"
            sub_path   = "media"
          }
          volume_mount {
            name       = "paperless"
            mount_path = "/usr/src/paperless/export"
            sub_path   = "export"
          }
          volume_mount {
            name       = "paperless"
            mount_path = "/usr/src/paperless/consume"
            sub_path   = "consume"
          }
        }
        volume {
          name = "paperless"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.paperless.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "paperless" {
  metadata {
    name      = "paperless"
    namespace = kubernetes_namespace.paperless.metadata[0].name
    labels = {
      "app" = "paperless"
    }
  }
  wait_until_bound = false
  spec {
    storage_class_name = var.storage_class
    access_modes       = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}


resource "kubernetes_config_map" "paperless" {
  metadata {
    name      = "paperless"
    namespace = kubernetes_namespace.paperless.metadata[0].name
  }

  data = {
    # General Settings
    "PAPERLESS_URL"  = var.url
    "PAPERLESS_PORT" = 8000
    # OCR Settings
    "PAPERLESS_OCR_LANGUAGE" = "eng"
    "PAPERLESS_OCR_MODE"     = "redo"
  }

}

resource "kubernetes_secret" "paperless" {
  metadata {
    name      = "paperless"
    namespace = kubernetes_namespace.paperless.metadata[0].name
  }
  data = {
    "PAPERLESS_SECRET_KEY"     = random_password.secret_key.result
    "PAPERLESS_ADMIN_USER"     = var.admin_user
    "PAPERLESS_ADMIN_MAIL"     = var.admin_email
    "PAPERLESS_ADMIN_PASSWORD" = var.admin_password
  }
}

resource "kubernetes_secret" "smtp_creds" {
  metadata {
    name      = "smtp-creds"
    namespace = kubernetes_namespace.paperless.metadata[0].name
  }
  data = var.smtp_creds
}

resource "random_password" "secret_key" {
  length = 50
}
