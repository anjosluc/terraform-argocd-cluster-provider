# Terraform ArgoCD Kubernetes Cluster Provider

Terraform module to add kubernetes cluster on ArgoCD.

## Usage

```hcl
provider "argocd" {
  server_addr = "${local.env[var.environment].argo_provider_host}:443"
  username    = var.argo_user
  password    = var.argo_ldap_password
}

module "argocd-provider" {
    source             = "git::https://github.com/anjosluc/terraform-argocd-cluster-provider.git?ref=master"
    
    argo_provider_host = "argocd.example.com"
    argo_user          = var.argo_user
    argo_ldap_password = var.argo_ldap_password
    clusterName        = var.clusterName
    clusterEndpoint    = data.aws_eks_cluster.cluster.endpoint
    clusterCAData      = data.aws_eks_cluster.cluster.certificate_authority.0.data
    accountID          = data.aws_caller_identity.current.account_id
    environment        = var.environment
    aws_region         = var.aws_region
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_argocd"></a> [argocd](#requirement\_argocd) | 4.1.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_argocd"></a> [argocd](#provider\_argocd) | 4.1.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [argocd_cluster.argocd_import_cluster](https://registry.terraform.io/providers/oboukili/argocd/4.1.0/docs/resources/cluster) | resource |
| [kubernetes_cluster_role.argocd_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/2.2.0/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.argocd_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/2.2.0/docs/resources/cluster_role_binding) | resource |
| [kubernetes_service_account.argocd_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/2.2.0/docs/resources/service_account) | resource |
| [kubernetes_secret.argocd_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/2.2.0/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accountID"></a> [accountID](#input\_accountID) | aws account id | `string` | n/a | yes |
| <a name="input_argo_ldap_password"></a> [argo\_ldap\_password](#input\_argo\_ldap\_password) | argo ldap password | `any` | n/a | yes |
| <a name="input_argo_provider_host"></a> [argo\_provider\_host](#input\_argo\_provider\_host) | Default argocd host | `string` | `"argocd.com"` | no |
| <a name="input_argo_user"></a> [argo\_user](#input\_argo\_user) | Argo admin default user | `string` | `"admin"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | aws region | `string` | n/a | yes |
| <a name="input_clusterCAData"></a> [clusterCAData](#input\_clusterCAData) | cluster certification authority data | `string` | n/a | yes |
| <a name="input_clusterEndpoint"></a> [clusterEndpoint](#input\_clusterEndpoint) | cluster kubernetes endpoint | `string` | n/a | yes |
| <a name="input_clusterName"></a> [clusterName](#input\_clusterName) | cluster name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->