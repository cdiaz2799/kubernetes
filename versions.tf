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

provider "kubernetes" {
  # Defined with $KUBE_CONFIG_PATH and $KUBE_CTX
}


provider "helm" {
  # Defined with $KUBE_CONFIG_PATH and $KUBE_CTX
}

provider "onepassword" {
  service_account_token = var.op_access_token
}
