locals {
  kube_namespace = "kube-system"
  default_namespace = "default"
}

resource "aws_eks_fargate_profile" "kube-system" {
  cluster_name         = local.cluster_name
  fargate_profile_name = local.kube_namespace

  pod_execution_role_arn = aws_iam_role.eks-cluster.arn

  # These subnets must have the following resource tag: 
  # kubernetes.io/cluster/<CLUSTER_NAME>.
  subnet_ids = var.fargate_subnet_list

  selector {
    namespace = local.kube_namespace
  }

  depends_on = [
    aws_eks_cluster.default
  ]
}

resource "aws_eks_fargate_profile" "default" {
  cluster_name           = aws_eks_cluster.default.name
  fargate_profile_name   = local.default_namespace

  pod_execution_role_arn = aws_iam_role.eks-cluster.arn

  subnet_ids = var.fargate_subnet_list

  selector {
    namespace = local.default_namespace
  }

  depends_on = [
    aws_eks_cluster.default
  ]
}