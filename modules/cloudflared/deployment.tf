resource "kubernetes_deployment" "cloudflared" {
  metadata {
    name      = "cloudflared"
    namespace = kubernetes_namespace.cloudflared.metadata[0].name
    labels = {
      "app" = "cloudflared"
    }
  }
  spec {
    replicas = "2"
    selector {
      match_labels = {
        "pod" = "cloudflared"
      }
    }
    template {
      metadata {
        labels = {
          "pod" = "cloudflared"
        }
      }
      spec {
        container {
          name  = "cloudflared"
          image = "cloudflare/cloudflared:latest"
          command = [
            "cloudflared",
            "tunnel",
            "--metrics",
            "0.0.0.0:2000",
            "run",
          ]
          args = [
            "--token",
            cloudflare_tunnel.default.tunnel_token
          ]
          liveness_probe {
            http_get {
              path = "/ready"
              port = "2000"
            }
            failure_threshold     = 1
            initial_delay_seconds = 10
            period_seconds        = 10
          }
        }
      }
    }
  }

}
