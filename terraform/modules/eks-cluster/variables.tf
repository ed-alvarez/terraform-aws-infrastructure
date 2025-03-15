variable "prefix" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "aws_vpc" {}

variable "eks_cluster_name" {
  type = string
}

variable "eks_cluster_version" {
  type = string
}

variable "eks_cluster_subnet_list" {
  type = list(string)
}

variable "eks_default_vpc_security_group" {
  type = string
}

variable "fargate_subnet_list" {
  type = list(string)
}