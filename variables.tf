variable "home_assistant_version" {
  description = "Tag for Home Asisstant Image"
  type        = string
  sensitive   = false
  default     = "stable"
}

variable "eufy_username" {
  description = "Eufy Account Username"
  type        = string
  sensitive   = true
}

variable "eufy_password" {
  description = "Eufy Account Password"
  type        = string
  sensitive   = true
}

variable "op_credentials_file" {
  description = "Path to 1Password Kubernetes Credentials File"
  type        = string
  sensitive   = true
}

variable "op_access_token" {
  description = "Value of 1Password Access Token"
  type        = string
  sensitive   = true
}
