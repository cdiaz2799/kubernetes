variable "paperless_port" {
  description = "Port for Paperless"
  type        = number
  default     = 8000
}

variable "storage_class" {
  description = "Storage Class for the Peristent Volume"
  type        = string
  default     = "nfs-csi"
}

variable "db_name" {
  description = "Database Name"
  type        = string
  default     = "paperless"
}

variable "db_user" {
  description = "Database User"
  type        = string
  default     = "paperless"
}

variable "tika_port" {
  description = "Port for Tika"
  type        = number
  default     = 9998
}

variable "gotenberg_port" {
  description = "Port for Gotenberg"
  type        = number
  default     = 3000
}

variable "url" {
  description = "URL for the Paperless instance"
  type        = string
}

variable "admin_user" {
  description = "Admin User for the Paperless instance"
  type        = string
}

variable "admin_email" {
  description = "Admin Email for the Paperless instance"
  type        = string
}

variable "admin_password" {
  description = "Admin Password for the Paperless instance"
  type        = string
  sensitive   = true
}

variable "smtp_creds" {
  description = "SMTP Credentials for the Paperless instance"
  sensitive   = true
  type = object({
    PAPERLESS_EMAIL_HOST          = string
    PAPERLESS_EMAIL_PORT          = number
    PAPERLESS_EMAIL_HOST_USER     = string
    PAPERLESS_EMAIL_HOST_PASSWORD = string
    PAPERLESS_EMAIL_FROM          = string
    PAPERLESS_EMAIL_USE_TLS       = bool
    PAPERLESS_EMAIL_USE_SSL       = bool
  })
}
