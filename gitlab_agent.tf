resource "helm_release" "gitlab" {
  repository = "https://charts.gitlab.io"
  name       = "homelab"
  chart      = "gitlab-agent"
  namespace  = kubernetes_namespace.gitlab_agent.metadata[0].name

  set {
    name  = "config.kasAddress"
    value = "wss://kas.gitlab.com"
  }

  set {
    name  = "config.secretName"
    value = kubernetes_secret.gitlab_agent_token.metadata[0].name
  }

}

resource "kubernetes_secret" "gitlab_agent_token" {
  metadata {
    name      = "gitlab-agent-token"
    namespace = kubernetes_namespace.gitlab_agent.metadata[0].name
  }
  data = {
    "token" = var.gitlab_access_token
  }
}

resource "kubernetes_namespace" "gitlab_agent" {
  metadata {
    name = "gitlab-agent"
  }
}
