resource "kubernetes_stateful_set" "default" {
  metadata {
    name      = "postgres"
    namespace = var.namespace
    labels    = local.app_label
  }
  wait_for_rollout = true
  spec {
    service_name = kubernetes_service.default.metadata[0].name
    selector {
      match_labels = local.app_label
    }
    template {
      metadata {
        labels = local.app_label
      }
      spec {
        container {
          name  = "postgres"
          image = "postgres:${var.postgres_version}"

          port {
            name           = "sql"
            protocol       = "TCP"
            container_port = 5432
          }

          readiness_probe {
            initial_delay_seconds = 30
            period_seconds        = 10
            timeout_seconds       = 1
            success_threshold     = 1
            failure_threshold     = 3

          }

          liveness_probe {
            initial_delay_seconds = 30
            period_seconds        = 10
            timeout_seconds       = 1
            success_threshold     = 1
            failure_threshold     = 3
          }

          startup_probe {
            initial_delay_seconds = 30
            period_seconds        = 10
            timeout_seconds       = 1
            success_threshold     = 1
            failure_threshold     = 3

          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.default.metadata[0].name
            }
          }
          env_from {
            secret_ref {
              name = kubernetes_secret.default.metadata[0].name
            }
          }

          volume_mount {
            name       = var.pvc_name
            mount_path = "/var/lib/postgresql/data"
            sub_path   = "db"
          }
        }
        volume {
          name = var.pvc_name
          persistent_volume_claim {
            claim_name = var.pvc_name
          }
        }
      }
    }
  }

}

resource "kubernetes_service" "default" {
  metadata {
    name      = "postgres"
    namespace = var.namespace
    labels    = local.app_label
  }
  spec {
    type                    = "ClusterIP"
    external_traffic_policy = "Local"
    port {
      name        = "sql"
      protocol    = "TCP"
      target_port = "5432"
      port        = var.service_port
    }
  }

}

resource "kubernetes_secret" "default" {
  metadata {
    name      = "postgres"
    namespace = var.namespace
    labels    = local.app_label
  }
  data = {
    "POSTGRES_PASSWORD" = var.password
  }
}


resource "kubernetes_config_map" "default" {
  metadata {
    name      = "postgres"
    namespace = var.namespace
    labels    = local.app_label
  }
  data = {
    "POSTGRES_DB"   = var.db_name
    "POSTGRES_USER" = var.username
  }
}

locals {
  app_label = {
    "app"       = var.app_name
    "component" = "postgres-db"
  }
}