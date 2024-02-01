
module "paperless-db" {
  app_name  = "paperless-ngx"
  source    = "./modules/postgres"
  namespace = kubernetes_namespace.paperless.metadata[0].name

  db_name  = "paperless"
  username = "paperless"
  password = random_password.paperless-db.result

  pvc_name = kubernetes_persistent_volume_claim.paperless.metadata[0].name
}

resource "kubernetes_persistent_volume_claim" "paperless" {
  metadata {
    name      = "paperless"
    namespace = kubernetes_namespace.paperless.metadata[0].name
    labels = {
      "app" = "paperless"
    }
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "10Gi"
      }
    }
  }
}

resource "kubernetes_namespace" "paperless" {
  metadata {
    name = "paperless"
  }
}

resource "random_password" "paperless-db" {
  length = 24
}
