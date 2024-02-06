resource "kubernetes_service" "gotenberg" {
  metadata {
    name      = "gotenberg"
    namespace = kubernetes_namespace.paperless.metadata[0].name
    labels = {
      "app"       = "paperless"
      "component" = "gotenberg"
    }
  }
  spec {
    selector = {
      "app"       = "paperless"
      "component" = "gotenberg"
    }
    port {
      name        = "gotenberg"
      port        = var.gotenberg_port
      target_port = 3000
    }
  }
}


resource "kubernetes_deployment" "gotenberg" {
  metadata {
    name      = "gotenberg"
    namespace = kubernetes_namespace.paperless.metadata[0].name
    labels = {
      "app"       = "paperless"
      "component" = "gotenberg"
    }
  }
  spec {
    replicas = "1"
    selector {
      match_labels = {
        "app"       = "paperless"
        "component" = "gotenberg"
      }
    }
    template {
      metadata {
        labels = {
          "app"       = "paperless"
          "component" = "gotenberg"
        }
      }
      spec {
        container {
          name  = "gotenberg"
          image = "docker.io/gotenberg/gotenberg:7.10"
          port {
            name           = "gotenberg"
            container_port = 3000
          }
          command = ["gotenberg", "--chromium-disable-javascript=true", "--chromium-allow-list=file:///tmp/.*"]
        }
      }
    }
  }
}
