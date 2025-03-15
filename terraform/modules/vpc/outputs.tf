output "aws_vpc" {
  value = aws_vpc.default
}

output "default-private-subnet-a" {
  value = aws_subnet.default-private-a.id
}

output "default-private-subnet-b" {
  value = aws_subnet.default-private-b.id
}

output "default-public-subnet-a" {
  value = aws_subnet.default-public-a.id
}

output "default-public-subnet-b" {
  value = aws_subnet.default-public-b.id
}

output "default-security-group" {
  value = aws_default_security_group.default.id
}
