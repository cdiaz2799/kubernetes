terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.25.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12.1"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = ">= 1.4.1"
    }
  }
}
