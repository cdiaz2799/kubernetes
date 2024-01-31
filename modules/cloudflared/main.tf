terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.25.2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4.23.0"
    }
  }
}

resource "kubernetes_namespace" "cloudflared" {
  metadata {
    name = "cloudflared"
  }
}
