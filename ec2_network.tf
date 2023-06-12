resource "aws_eip" "e_ip" {
  domain           = "vpc"
  public_ipv4_pool = "amazon"
}

resource "aws_nat_gateway" "nat_gateway" {
  depends_on    = [aws_eip.e_ip]
  allocation_id = aws_eip.e_ip.id
  subnet_id     = aws_subnet.My_VPC_Subnet.id

  tags = {
    Name = "nat_gateway"
  }
}