resource "kubernetes_config_map" "postgresql" {
  metadata {
    name      = "paperless-postgresql"
    namespace = kubernetes_namespace.paperless.metadata[0].name
  }
  data = {
    "PAPERLESS_DBENGINE" = "postgresql"
    "PAPERLESS_DBHOST"   = "${helm_release.postgres-db.name}-hl.${helm_release.postgres-db.namespace}"
    "PAPERLESS_DBPORT"   = "5432"
    "PAPERLESS_DBNAME"   = var.db_name
    "PAPERLESS_DBUSER"   = var.db_user
  }
}

resource "kubernetes_secret" "postgres-db" {
  metadata {
    name      = "paperless-postgresql"
    namespace = kubernetes_namespace.paperless.metadata[0].name
  }
  data = {
    "PAPERLESS_DBPASS" = random_password.paperless-db.result
  }

}


resource "helm_release" "postgres-db" {
  name       = "postgresql"
  chart      = "postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  namespace  = kubernetes_namespace.paperless.metadata[0].name
  set {
    name  = "global.storageClass"
    value = var.storage_class
  }

  set {
    name  = "architecture"
    value = "standalone"
  }

  set {
    name  = "auth.username"
    value = var.db_user
  }

  set {
    name  = "auth.database"
    value = var.db_name
  }

  set {
    name  = "auth.existingSecret"
    value = kubernetes_secret.paperless-db.metadata[0].name
  }

  set {
    name  = "auth.secretKeys.userPasswordKey"
    value = "password"
  }
}

resource "kubernetes_secret" "paperless-db" {
  metadata {
    name      = "paperless-db"
    namespace = kubernetes_namespace.paperless.metadata[0].name
  }
  data = {
    "password"          = random_password.paperless-db.result
    "postgres-password" = random_password.paperless-postgres.result
  }
}

resource "random_password" "paperless-db" {
  length = 24
}
resource "random_password" "paperless-postgres" {
  length = 24
}
