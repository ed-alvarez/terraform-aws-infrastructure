output "eks_cluster" {
  value = aws_eks_cluster.default
}

output "eks_cluster_auth" {
  value = data.aws_eks_cluster_auth.default
}

output "eks_default_profile" {
  value = aws_eks_fargate_profile.default
}

output "eks_kube_system_profile" {
  value = aws_eks_fargate_profile.kube-system
}

output "helm_aws_load_balancer_chart" {
  value = helm_release.aws-load-balancer-controller
}