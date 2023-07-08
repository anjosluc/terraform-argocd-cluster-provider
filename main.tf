# Create the service account, cluster role + binding, which ArgoCD expects to be present in the targeted cluster
resource "kubernetes_service_account" "argocd_manager" {
  metadata {
    name      = "argocd-manager"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role" "argocd_manager" {
  metadata {
    name = "argocd-manager-role"
  }

  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }

  rule {
    non_resource_urls = ["*"]
    verbs             = ["*"]
  }
}

resource "kubernetes_cluster_role_binding" "argocd_manager" {
  metadata {
    name = "argocd-manager-role-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.argocd_manager.metadata.0.name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.argocd_manager.metadata.0.name
    namespace = kubernetes_service_account.argocd_manager.metadata.0.namespace
  }
}

data "kubernetes_secret" "argocd_manager" {
  metadata {
    name      = kubernetes_service_account.argocd_manager.default_secret_name
    namespace = kubernetes_service_account.argocd_manager.metadata.0.namespace
  }
}

resource "argocd_cluster" "argocd_import_cluster" {
  server = format("%s", var.clusterEndpoint) #data.aws_eks_cluster.cluster.endpoint
  name   = var.clusterName

  config {
    bearer_token = data.kubernetes_secret.argocd_manager.data["token"]
    tls_client_config {
      ca_data      = base64decode(var.clusterCAData) #data.aws_eks_cluster.cluster.certificate_authority.0.data
    }
  }

  metadata {
    labels = {
        "name"          = var.clusterName #local.env[var.environment].cluster_name
        "environment"   = var.environment #split("_", var.environment)[0]
        "region"        = var.aws_region
        "aws_account"   = var.accountID # data.aws_caller_identity.current.account_id
    }
  }
}