resource "helm_release" "op-helm-release" {
  name       = "1password"
  repository = "https://1password.github.io/connect-helm-charts"
  chart      = "connect"
  namespace  = "1password"

  set {
    name  = "connect.credentialsName"
    value = kubernetes_secret.op-credentials-file.metadata[0].name
  }

  set {
    name  = "operator.create"
    value = true
  }

  set {
    name  = "operator.token.name"
    value = kubernetes_secret.op_access_token.metadata[0].name
  }
}

resource "kubernetes_secret" "op-credentials-file" {
  metadata {
    name = "op-service-account"
  }
  data = {
    token = file("${var.op_credentials_file}")
  }
}

resource "kubernetes_secret" "op_access_token" {
  metadata {
    name = "op-access-token"
  }
  data = {
    token = var.op_access_token
  }
}
