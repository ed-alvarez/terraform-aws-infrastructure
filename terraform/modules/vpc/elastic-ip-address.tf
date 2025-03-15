resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "default-eip-nat-${var.environment}"
  }
}