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
    type = "ClusterIP"
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
            secret_ref {
              name = kubernetes_secret.paperless-db.metadata[0].name
            }
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.smtp_creds.metadata[0].name
            }
          }
        }
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
    "PAPERLESS_URL" = var.url
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
