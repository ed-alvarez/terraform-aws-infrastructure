provider "aws" {
  region = var.aws_region

  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key

  default_tags {
    tags = {
      Environment = var.environment
      Terraform   = true
    }
  }
}

provider "kubernetes" {
  host                   = module.eks-cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(module.eks-cluster.eks_cluster.certificate_authority[0].data)
  token                  = module.eks-cluster.eks_cluster_auth.token
}

provider "helm" {
  kubernetes {
    host                   = module.eks-cluster.eks_cluster.endpoint
    cluster_ca_certificate = base64decode(module.eks-cluster.eks_cluster.certificate_authority[0].data)
    token                  = module.eks-cluster.eks_cluster_auth.token
  }
}
