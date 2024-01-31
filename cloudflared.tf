module "cloudflared_tunnel" {
  source = "./modules/cloudflared"

  cloudflare_tunnel_name = "Homelab Kubernetes"
  cloudflare_account_id  = data.onepassword_item.cloudflare.username

}

data "onepassword_item" "cloudflare" {
  vault = var.op_vault
  title = "Cloudflare"
}
