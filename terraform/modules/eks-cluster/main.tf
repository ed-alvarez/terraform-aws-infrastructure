locals {
  # Formatted EKS cluster service name.
  #
  # Do not use this on resource names. Instead, specify ${var.eks_cluster_name} directly.
  cluster_name = "${var.prefix}-${var.eks_cluster_name}-${var.environment}"
}

resource "aws_eks_cluster" "default" {
  name    = local.cluster_name
  version = var.eks_cluster_version

  role_arn = aws_iam_role.eks-cluster.arn

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true

    security_group_ids = [var.eks_default_vpc_security_group]

    subnet_ids = var.eks_cluster_subnet_list
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-policy
  ]
}

data "aws_eks_cluster_auth" "default" {
  name = aws_eks_cluster.default.id
}
