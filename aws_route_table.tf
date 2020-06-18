resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.app-name}-public-route-table"
  }
}

resource "aws_route_table" "private-route-table-a" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-a.id
  }

  tags = {
    Name = "${var.app-name}-private-route-table-a"
  }
}

resource "aws_route_table" "private-route-table-c" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-c.id
  }

  tags = {
    Name = "${var.app-name}-private-route-table-c"
  }
}

resource "aws_route_table_association" "public-subnet-a" {
  subnet_id      = aws_subnet.public-subnet-a.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-subnet-c" {
  subnet_id      = aws_subnet.public-subnet-c.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private-subnet-a" {
  subnet_id      = aws_subnet.private-subnet-a.id
  route_table_id = aws_route_table.private-route-table-a.id
}

resource "aws_route_table_association" "private-subnet-c" {
  subnet_id      = aws_subnet.private-subnet-c.id
  route_table_id = aws_route_table.private-route-table-c.id
}
