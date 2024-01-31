resource "kubernetes_storage_class" "nfs" {
  metadata {
    name = "nfs-csi"
  }
  storage_provisioner = "nfs.csi.k8s.io"
  parameters = {
    "server" = "192.168.1.248"
    "share"  = "/srv/nfs"
  }
  reclaim_policy      = "Delete"
  volume_binding_mode = "Immediate"
  mount_options       = ["hard", "nfsvers=4.1"]

}


resource "kubernetes_namespace" "home-automation" {
  metadata {
    name = "home-automation"
  }
}

data "cloudflare_zone" "domain" {
  name = var.cloudflare_zone
}
