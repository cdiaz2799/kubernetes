resource "cloudflare_record" "actual" {
  name    = "budget"
  type    = "CNAME"
  zone_id = data.cloudflare_zone.domain.zone_id
  value   = module.cloudflared_tunnel.cloudflared_cname
  proxied = true
}

resource "kubernetes_service" "actual" {
  metadata {
    name      = "actual"
    namespace = kubernetes_namespace.actual.metadata[0].name
  }
  spec {
    selector = {
      "app" = "actual"
    }
    type = "ClusterIP"
    port {
      name = "actual"
      port = 5006
    }
  }

}

resource "kubernetes_deployment" "actual" {
  metadata {
    name      = "actual"
    namespace = kubernetes_namespace.actual.metadata[0].name
    labels = {
      "app" = "actual"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        "app" = "actual"
      }
    }
    template {
      metadata {
        labels = {
          "app" = "actual"
        }
      }
      spec {
        container {
          name  = "actual-budget"
          image = "docker.io/actualbudget/actual-server:latest-alpine"

          port {
            name           = "actual"
            container_port = 5006
          }

          resources {
            requests = {
              "memory" = "256Mi"
            }
            limits = {
              "memory" = "512Mi"
            }
          }

          volume_mount {
            name       = "actual-data"
            mount_path = "/data"
          }
        }
        volume {
          name = "actual-data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.actual.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "actual" {
  metadata {
    name      = "budget-data"
    namespace = kubernetes_namespace.actual.metadata[0].name
    labels = {
      "app" = "actual"
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

resource "kubernetes_namespace" "actual" {
  metadata {
    name = "budget"
  }
}