output "cloudflared_namespace" {
  value = kubernetes_namespace.cloudflared.metadata[0].name
}

output "cloudflared_tunnel_name" {
  value = cloudflare_tunnel.default.name
}

output "cloudflared_cname" {
  value = cloudflare_tunnel.default.cname
}

output "cloudflared_tunnel_id" {
  value = cloudflare_tunnel.default.id
}