variable "home_assistant_version" {
  description = "Tag for Home Asisstant Image"
  type        = string
  sensitive   = false
  default     = "stable"
}

variable "op_vault" {
  description = "Name of 1Password Vault"
  type        = string
  sensitive   = true
}

variable "op_access_token" {
  description = "Value of 1Password Access Token"
  type        = string
  sensitive   = true
}

variable "gitlab_access_token" {
  description = "GitLab Agent Access Token"
  type        = string
  sensitive   = true
}

variable "plane_ingress" {
  description = "Plane Ingress"
  type        = string
  sensitive   = false
  default     = "plane.cdiaz.cloud"
}

variable "cloudflare_zone" {
  description = "Cloudflare Domain / Zone"
  type        = string
  sensitive   = false
  default     = "cdiaz.cloud"
}
