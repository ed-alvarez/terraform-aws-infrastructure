locals {
  eks_cluster_name = "${var.prefix}-${var.eks_cluster_name}-${var.environment}"
}

resource "aws_subnet" "default-private-a" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "${var.aws_region}a"

  tags = {
    "Name"                                      = "default-private-${var.aws_region}a"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "owned"
  }
}

resource "aws_subnet" "default-private-b" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = "${var.aws_region}b"

  tags = {
    "Name"                                      = "default-private-${var.aws_region}b"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "owned"
  }
}

resource "aws_subnet" "default-public-a" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "default-public-${var.aws_region}a"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "owned"
  }
}

resource "aws_subnet" "default-public-b" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "default-public-${var.aws_region}b"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "owned"
  }
}
