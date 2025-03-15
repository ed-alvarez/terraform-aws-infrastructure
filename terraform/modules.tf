module "vpc" {
  source = "./modules/vpc"

  prefix      = var.prefix
  environment = var.environment

  aws_region = var.aws_region

  default_vpc_cidr = var.default_vpc_cidr

  # Subnets must have resorce tag pointing to cluster name
  eks_cluster_name = var.eks_cluster_name
}

module "eks-cluster" {
  source = "./modules/eks-cluster"

  prefix      = var.prefix
  environment = var.environment

  aws_region = var.aws_region
  aws_vpc    = module.vpc.aws_vpc

  eks_cluster_name    = var.eks_cluster_name
  eks_cluster_version = var.eks_cluster_version

  eks_default_vpc_security_group = module.vpc.default-security-group

  eks_cluster_subnet_list = [
    module.vpc.default-private-subnet-a,
    module.vpc.default-private-subnet-b,
    module.vpc.default-public-subnet-a,
    module.vpc.default-public-subnet-b
  ]

  fargate_subnet_list = [
    module.vpc.default-private-subnet-a,
    module.vpc.default-private-subnet-b
  ]
}

module "k8s-koloni-api" {
  source = "./modules/k8s-koloni-api"

  environment     = var.environment
  k8s_images_repo = var.k8s_images_repo

  koloni_api_env = local.koloni_api_env

  depends_on = [
    module.eks-cluster.eks_kube_system_profile,
    module.eks-cluster.eks_default_profile,
    module.eks-cluster.helm_aws_load_balancer_chart
  ]
}

module "k8s-lockers-admin-panel" {
  source = "./modules/k8s-lockers-admin-panel"

  environment     = var.environment
  k8s_images_repo = var.k8s_images_repo

  depends_on = [
    module.eks-cluster.eks_kube_system_profile,
    module.eks-cluster.eks_default_profile,
    module.eks-cluster.helm_aws_load_balancer_chart
  ]
}

module "k8s-storage-app-lite" {
  source = "./modules/k8s-storage-app-lite"

  environment     = var.environment
  k8s_images_repo = var.k8s_images_repo

  depends_on = [
    module.eks-cluster.eks_kube_system_profile,
    module.eks-cluster.eks_default_profile,
    module.eks-cluster.helm_aws_load_balancer_chart
  ]
}

module "k8s-lite-app" {
  source = "./modules/k8s-lite-app"

  environment     = var.environment
  k8s_images_repo = var.k8s_images_repo

  depends_on = [
    module.eks-cluster.eks_kube_system_profile,
    module.eks-cluster.eks_default_profile,
    module.eks-cluster.helm_aws_load_balancer_chart
  ]
}
