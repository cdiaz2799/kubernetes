resource "cloudflare_tunnel" "default" {
  account_id = var.cloudflare_account_id
  name       = var.cloudflare_tunnel_name
  config_src = "cloudflare"
  secret     = base64sha256(random_password.tunnel_secret.result)

}

resource "random_password" "tunnel_secret" {
  length = 64
}
