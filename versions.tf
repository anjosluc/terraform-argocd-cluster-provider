terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.2.0"
    }
    argocd    = {
      source = "oboukili/argocd"
      version = "4.1.0"
    }
  }
}