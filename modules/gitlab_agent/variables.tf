variable "gitlab_access_token_secret" {
  description = "1Password Item for GitLab Agent Access Token"
  type        = string
  sensitive   = true
  default     = "Gitlab Agent Access Token"
}

variable "op_vault" {
  description = "Name of 1Password Vault"
  type        = string
  sensitive   = true
}
