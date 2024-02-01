variable "namespace" {
  description = "Namespace to deploy PostgreSQL in to"
}

variable "app_name" {
  description = "App Name for Label"
  type        = string
}

variable "postgres_version" {
  description = "PostgreSQL Version"
  default     = 16
}

variable "username" {
  description = "Name for a database user to create"
  type        = string
}

variable "password" {
  description = "Password for database user"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Name for a custom database to create"
  type        = string
  sensitive   = false
}

variable "pvc_name" {
  description = "Required Persistent Volume Claim"
  type        = string
}

variable "service_port" {
  description = "Port to bind PostgreSQL to"
  type        = number
  default     = 5432
}