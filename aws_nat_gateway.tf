resource "aws_eip" "nat_a" {
  vpc = true
}

resource "aws_eip" "nat_c" {
  vpc = true
}

resource "aws_nat_gateway" "nat_a" {
  allocation_id = aws_eip.nat_a.id
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name = "${var.app-name}-natgw-a"
  }
}

resource "aws_nat_gateway" "nat_c" {
  allocation_id = aws_eip.nat_c.id
  subnet_id     = aws_subnet.public_c.id

  tags = {
    Name = "${var.app-name}-natgw-c"
  }
}
