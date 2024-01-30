resource "helm_release" "plane" {
  name       = "makeplane"
  repository = "https://helm.plane.so/"
  namespace  = kubernetes_namespace.plane.metadata[0].name
  chart      = "makeplane/plane-ce"

  set {
    name  = "ingress.appHost"
    value = var.app_ingress
  }

  set {
    name  = "ingress.minioHost"
    value = var.minio_ingress
  }

  set {
    name  = "redis.storageClass"
    value = var.cluster_storage_class
  }

  set {
    name  = "postgres.storageClass"
    value = var.cluster_storage_class
  }

  set {
    name  = "minio.storageClass"
    value = var.cluster_storage_class
  }

  set {
    name  = "smtp.host"
    value = var.smtp_host
  }

  set {
    name  = "smtp.user"
    value = var.smtp_user
  }

  set {
    name  = "smtp.password"
    value = var.smtp_password
  }

  set {
    name  = "smtp.port"
    value = var.smtp_port
  }

  set {
    name  = "smtp.from"
    value = var.smtp_from
  }

  set {
    name  = "smtp.use_tls"
    value = var.smtp_tls_enabled
  }

  set {
    name  = "smtp.use_ssl"
    value = var.smtp_ssl_enabled
  }
}

resource "kubernetes_namespace" "plane" {
  metadata {
    name = "plane"
  }
}
