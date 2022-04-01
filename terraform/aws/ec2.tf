data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "iut-test" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = "t2.micro"
  key_name          = aws_key_pair.key.key_name
  security_groups   = [aws_security_group.allow_all.name]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = aws_instance.iut-test.public_ip
    port        = 22
    private_key = tls_private_key.tls-private-key.private_key_pem
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install python3-pip -y",
      "sudo pip install flask"
    ]
  }

  provisioner "file" {
    source = "resources/app.py"
    destination = "/home/ubuntu/app.py"
  }

  tags = {
    Name = "HelloWorld"
  }
}