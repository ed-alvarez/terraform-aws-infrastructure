# Environment configuration

variable "prefix" {
  description = "Resource prefix"
  type        = string
  default     = "koloni"
}

variable "environment" {
  description = "Environment name"
  type        = string
}

# AWS Provider

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_secret_access_key" {
  description = "AWS secret access key"
  type        = string
}

variable "aws_access_key_id" {
  description = "AWS access key id"
  type        = string
}

# AWS VPC configuration

variable "default_vpc_cidr" {
  description = "Default VPC CIDR block"
  type        = string
}

# AWS EKS cluster configuration

variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "eks_cluster_version" {
  description = "EKS cluster version"
  type        = string
}

variable "eks_certificate_arn" {
  description = "AWS certificate ARN for HTTPS"
  type        = string
}

# AWS RDS configuration

variable "rds_database_name" {
  description = "RDS database name"
  type        = string
}

variable "rds_master_username" {
  description = "RDS master username"
  type        = string
}

variable "rds_master_password" {
  description = "RDS master password"
  type        = string
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
}

# Kubernetes 

variable "k8s_images_repo" {
  description = "ECR images repository"
  type        = string
}
