resource "aws_vpc" "default" {
  cidr_block = var.default_vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.prefix}-default-vpc-${var.environment}"
  }
}
