resource "aws_vpc" "My_VPC" {
  cidr_block           = "192.168.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "My VPC"
  }
}

resource "aws_subnet" "My_VPC_Subnet" {
  vpc_id                  = aws_vpc.My_VPC.id
  cidr_block              = "192.168.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-1a"

  tags = {
    Name = "My VPC Subnet"
  }
}

resource "aws_subnet" "My_VPC_Subnet2" {
  vpc_id            = aws_vpc.My_VPC.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "us-west-1b"

  tags = {
    Name = "My VPC Subnet"
  }
}

resource "aws_internet_gateway" "My_VPC_GW" {
  vpc_id = aws_vpc.My_VPC.id

  tags = {
    Name = "My VPC Internet Gateway"
  }
}

resource "aws_route_table" "My_VPC_route_table" {
  vpc_id = aws_vpc.My_VPC.id

  tags = {
    Name = "My VPC Route Table"
  }
}

resource "aws_route" "My_VPC_internet_access" {
  route_table_id         = aws_route_table.My_VPC_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.My_VPC_GW.id
}

resource "aws_route_table_association" "My_VPC_association" {
  subnet_id      = aws_subnet.My_VPC_Subnet.id
  route_table_id = aws_route_table.My_VPC_route_table.id
}

resource "aws_route_table" "private_subnet_route_table" {
  depends_on = [aws_nat_gateway.nat_gateway]
  vpc_id     = aws_vpc.My_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "private_subnet_route_table"
  }
}

resource "aws_route_table_association" "private_subnet_route_table_association" {
  depends_on     = [aws_route_table.private_subnet_route_table]
  subnet_id      = aws_subnet.My_VPC_Subnet2.id
  route_table_id = aws_route_table.private_subnet_route_table.id
}