resource "aws_route_table" "default_private" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.default.id
  }

  tags = {
    Name = "private"
  }
}

resource "aws_route_table" "default_public" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "default-private-a" {
  subnet_id      = aws_subnet.default-private-a.id
  route_table_id = aws_route_table.default_private.id
}

resource "aws_route_table_association" "default-private-b" {
  subnet_id      = aws_subnet.default-private-b.id
  route_table_id = aws_route_table.default_private.id
}

resource "aws_route_table_association" "default-public-a" {
  subnet_id      = aws_subnet.default-public-a.id
  route_table_id = aws_route_table.default_public.id
}

resource "aws_route_table_association" "default-public-b" {
  subnet_id      = aws_subnet.default-public-b.id
  route_table_id = aws_route_table.default_public.id
}
