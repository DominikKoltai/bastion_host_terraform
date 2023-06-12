resource "tls_private_key" "tls_p_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "tls_p_key_pair" {
  key_name   = "tls_p_key_pair"
  public_key = tls_private_key.tls_p_key.public_key_openssh
}

resource "local_file" "private_key" {
  depends_on = [
    tls_private_key.tls_p_key,
  ]
  content  = tls_private_key.tls_p_key.private_key_pem
  filename = "webserver.pem"
}