output "paperless_url" {
  value = "http://${kubernetes_service.paperless.metadata[0].name}.${kubernetes_service.paperless.metadata[0].name}.svc.cluster.local:${kubernetes_service.paperless.spec[0].port[0].port}"
}
