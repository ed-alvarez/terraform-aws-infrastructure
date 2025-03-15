resource "aws_nat_gateway" "default" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.default-public-a.id

  tags = {
    Name = "default-nat-gateway-${var.environment}"
  }

  depends_on = [aws_internet_gateway.default]
}
