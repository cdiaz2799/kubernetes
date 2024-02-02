resource "helm_release" "paperless-redis" {
  name       = "redis"
  chart      = "redis"
  namespace  = kubernetes_namespace.paperless.metadata[0].name
  repository = "https://charts.bitnami.com/bitnami"

  set {
    name  = "global.storageClass"
    value = var.storage_class
  }

  set {
    name  = "architecture"
    value = "standalone"
  }

  set {
    name  = "auth.enabled"
    value = "false"
  }
}

resource "kubernetes_config_map" "paperless-redis" {
  metadata {
    name      = "redis"
    namespace = kubernetes_namespace.paperless.metadata[0].name
  }
  data = {
    "PAPERLESS_REDIS" = "redis://${helm_release.paperless-redis.name}-headless.${helm_release.paperless-redis.namespace}:6379"
  }

}
