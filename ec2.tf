resource "aws_instance" "bastionhost" {
  ami                    = "ami-0f8e81a3da6e2510a"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.My_VPC_Subnet.id
  vpc_security_group_ids = [aws_security_group.only_ssh_bastion.id]
  key_name               = "tls_p_key_pair"

  tags = {
    Name = "bastionhost"
  }
}

resource "aws_instance" "database" {
  ami                    = "ami-0f8e81a3da6e2510a"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.My_VPC_Subnet2.id
  vpc_security_group_ids = [aws_security_group.allow_wordpress.id, aws_security_group.only_ssh_sql_bastion.id]
  key_name               = "tls_p_key_pair"

  tags = {
    Name = "database"
  }
}

resource "aws_instance" "wordpress_os" {
  ami                    = "ami-0f8e81a3da6e2510a"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.My_VPC_Subnet.id
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  key_name               = "tls_p_key_pair"

  tags = {
    Name = "wordpress_os"
  }
}