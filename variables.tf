variable "argo_provider_host" {
    type = string
    default = "argocd.example.com"
    description = "Default argocd host"
}

variable "argo_user" {
    type = string
    default = "admin"
    description = "Argo admin default user"
}

variable "argo_ldap_password" {
  sensitive = true
  description = "argo ldap password"
}

variable "clusterName" {
    type = string
    description = "cluster name"
}

variable "environment" {
    type = string
    description = "environment to use"
}


variable "clusterEndpoint" {
    type = string
    description = "cluster kubernetes endpoint"
}

variable "clusterCAData" {
    type = string
    description = "cluster certification authority data"
}

variable "accountID" {
    type = string
    description = "aws account id"
}

variable "aws_region" {
    type = string
    description = "aws region"
}
