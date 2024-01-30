variable "app_ingress" {
  description = "Plane's primary ingress"
  type        = string
}

variable "minio_ingress" {
  description = "(Optional) Required to open minio console interface"
  type        = string
  default     = null
}

variable "cluster_storage_class" {
  description = "Storage Class"
  type        = string
  default     = "nfs-csi"
}

variable "smtp_host" {
  description = "SMTP Host"
  type        = string
}

variable "smtp_user" {
  description = "SMTP Username"
  type        = string
}

variable "smtp_password" {
  description = "SMTP Password"
  type        = string
  sensitive   = true
}

variable "smtp_port" {
  description = "SMTP Port"
  type        = number
  default     = 587
}

variable "smtp_from" {
  description = "SMTP From Address"
  type        = string
}

variable "smtp_tls_enabled" {
  type        = number
  default     = 1
  description = "SMTP TLS Enabled (1 - enabled; 0 - disabled)"
}


variable "smtp_ssl_enabled" {
  type        = number
  default     = 0
  description = "SMTP SSL Enabled (1 - enabled; 0 - disabled)"
}
