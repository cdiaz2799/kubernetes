output "cloudflared_namespace" {
  value = kubernetes_namespace.cloudflared.metadata[0].name
}

output "cloudflared_tunnel_name" {
  value = cloudflare_tunnel.default.name
}
