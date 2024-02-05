resource "cloudflare_record" "paperless" {
  name    = "paperless"
  type    = "CNAME"
  zone_id = data.cloudflare_zone.domain.zone_id
  value   = module.cloudflared_tunnel.cloudflared_cname
  proxied = true
  comment = "Managed by Terraform"
}
module "paperless" {
  source = "./modules/paperless"

  url            = "paperless.cdiaz.cloud"
  admin_user     = "value"
  admin_email    = "value"
  admin_password = "value"

  smtp_creds = {
    PAPERLESS_EMAIL_FROM          = data.onepassword_item.smtp.username
    PAPERLESS_EMAIL_HOST          = data.onepassword_item.smtp.hostname
    PAPERLESS_EMAIL_HOST_USER     = data.onepassword_item.smtp.username
    PAPERLESS_EMAIL_HOST_PASSWORD = data.onepassword_item.smtp.password
    PAPERLESS_EMAIL_PORT          = data.onepassword_item.smtp.port
    PAPERLESS_EMAIL_USE_SSL       = true
    PAPERLESS_EMAIL_USE_TLS       = true
  }
}

data "onepassword_item" "smtp" {
  vault = var.op_vault
  title = "SMTP Credentials"

}
