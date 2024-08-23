

resource "aws_security_group" "security-group" {
  description = "Allowing access to Jenkins, Sonarqube & SSH Access"
  vpc_id      = var.vpc_id


  # Ingress rules for CIDR blocks
  dynamic "ingress" {
    for_each = var.create_ingress_cidr ? toset(range(length(var.ingress_cidr_from_port))) : []
    content {
      from_port   = var.ingress_cidr_from_port[ingress.key]
      to_port     = var.ingress_cidr_to_port[ingress.key]
      protocol    = var.ingress_cidr_protocol[ingress.key]
      cidr_blocks = var.ingress_cidr_block
      description = var.ingress_cidr_description[ingress.key]
    }
  }


  # Egress rules for CIDR blocks
  dynamic "egress" {
    for_each = var.create_egress_cidr ? toset(range(length(var.egress_cidr_from_port))) : []
    content {
      from_port   = var.egress_cidr_from_port[egress.key]
      to_port     = var.egress_cidr_to_port[egress.key]
      protocol    = var.egress_cidr_protocol[egress.key]
      cidr_blocks = var.egress_cidr_block
    }
  }

  tags = {
    Name = var.sg-name
  }
}


/*
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.igw-name
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.rt-name
  }
}

resource "aws_route_table_association" "rta-public-subnet" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}*/