resource "tls_private_key" "tls-private-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.tls-private-key.private_key_pem
  filename        = "resources/iut-test.pem"
  file_permission = 0400
}

resource "aws_key_pair" "key" {
  key_name   = "iut_private_key"
  public_key = tls_private_key.tls-private-key.public_key_openssh
}