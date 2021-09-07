
resource "aws_vpc" "my-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = element(var.tags, 0)
  }
}

resource "aws_internet_gateway" "my-ig" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = element(var.tags, 1)
  }
}

resource "aws_subnet" "my-public-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = element(var.tags, 2)
  }
}

resource "aws_subnet" "my-private-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = element(var.tags, 3)
  }
}

resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-ig.id
  }

  tags = {
    Name = element(var.tags, 4)
  }
}

resource "aws_route_table" "my-private-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my-nat-gw.id
  }

  tags = {
    Name = element(var.tags, 5)
  }
}

resource "aws_route_table_association" "public-association" {
  subnet_id      = aws_subnet.my-public-subnet.id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_route_table_association" "private-association" {
  subnet_id      = aws_subnet.my-private-subnet.id
  route_table_id = aws_route_table.my-private-rt.id
}

resource "aws_eip" "terraform-eip" {
  vpc = true
  tags = {
    Name = element(var.tags, 6)
  }
}

resource "aws_nat_gateway" "my-nat-gw" {
  allocation_id = aws_eip.terraform-eip.id
  subnet_id     = aws_subnet.my-private-subnet.id
  tags = {
    Name = element(var.tags, 7)
  }
}