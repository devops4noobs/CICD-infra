resource "aws_vpc" "vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "my_VPC"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"
  tags = {
    Name = "my_public_subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "my_igw"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "my_public_routing_table"
  }
}

resource "aws_route_table_association" "rta-public-subnet" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}