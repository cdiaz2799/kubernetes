resource "kubernetes_config_map" "paperless-tika" {
  metadata {
    name      = "tika"
    namespace = kubernetes_namespace.paperless.metadata[0].name
  }
  data = {
    "PAPERLESS_TIKA_ENABLED"            = "true"
    "PAPERLESS_TIKA_ENDPOINT"           = "http://${kubernetes_service.tika.metadata[0].name}.${kubernetes_service.tika.metadata[0].namespace}:${kubernetes_service.tika.spec[0].port[0].port}"
    "PAPERLESS_TIKA_GOTENBERG_ENDPOINT" = "http://${kubernetes_service.gotenberg.metadata[0].name}.${kubernetes_service.gotenberg.metadata[0].namespace}:${kubernetes_service.gotenberg.spec[0].port[0].port}"

  }

}

resource "kubernetes_service" "tika" {
  metadata {
    name      = "tika"
    namespace = kubernetes_namespace.paperless.metadata[0].name
    labels = {
      "app"       = "paperless"
      "component" = "tika"
    }
  }
  spec {
    selector = {
      "app"       = "paperless"
      "component" = "tika"
    }
    port {
      name        = "tika"
      port        = var.tika_port
      target_port = 9998
    }
  }
}


resource "kubernetes_deployment" "tika" {
  metadata {
    name      = "tika"
    namespace = kubernetes_namespace.paperless.metadata[0].name
    labels = {
      "app"       = "paperless"
      "component" = "tika"
    }
  }
  spec {
    replicas = "1"
    selector {
      match_labels = {
        "app"       = "paperless"
        "component" = "tika"
      }
    }
    template {
      metadata {
        labels = {
          "app"       = "paperless"
          "component" = "tika"
        }
      }
      spec {
        container {
          name  = "tika"
          image = "ghcr.io/paperless-ngx/tika:latest"
          port {
            name           = "tika"
            container_port = 9998
          }
        }
      }
    }
  }
}
