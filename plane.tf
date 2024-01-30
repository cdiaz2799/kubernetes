module "plane" {
  source = "./modules/plane"

  app_ingress           = var.plane_ingress
  minio_ingress         = "plane-assets.cdiaz.cloud"
  cluster_storage_class = kubernetes_storage_class.nfs.metadata[0].name

  smtp_from        = data.onepassword_item.plane-smtp.username
  smtp_user        = data.onepassword_item.plane-smtp.username
  smtp_password    = data.onepassword_item.plane-smtp.password
  smtp_host        = data.onepassword_item.plane-smtp.hostname
  smtp_port        = data.onepassword_item.plane-smtp.port
  smtp_tls_enabled = 1
  smtp_ssl_enabled = 0

}

data "onepassword_item" "plane-smtp" {
  vault = var.op_vault
  title = "Plane - SMTP Credentials"

}
