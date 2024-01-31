resource "cloudflare_tunnel_config" "tunnel" {
  account_id = data.onepassword_item.cloudflare.username
  tunnel_id  = module.cloudflared_tunnel.cloudflared_tunnel_id
  config {
    ingress_rule {
      hostname = cloudflare_record.actual.name
      service  = "${kubernetes_service.actual.metadata[0].name}:${kubernetes_service.actual.spec[0].port[0].port}"
    }

    ingress_rule {
      service = "http_status:404"
    }
  }

}

module "cloudflared_tunnel" {
  source = "./modules/cloudflared"

  cloudflare_tunnel_name = "Homelab Kubernetes"
  cloudflare_account_id  = data.onepassword_item.cloudflare.username

}

data "onepassword_item" "cloudflare" {
  vault = var.op_vault
  title = "Cloudflare"
}
