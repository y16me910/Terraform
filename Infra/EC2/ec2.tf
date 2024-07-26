resource "aws_instance" "web" { #aws_instance==EC2, Web is this block name(uerDefined)
  ami           = "ami-0d7e17c1a01e6fa40" #Amazon Linux 2
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.security-group-allow-all.id]
  key_name = "tf-key-pair"

  tags = {
    Name = "EC2-Terraform"
  }
}

data "aws_vpc" "default-vcp" {
 default = true
}

resource "aws_security_group" "security-group-allow-all" {
 name        = "AlloAll-terraform-sg"
 description = "Allow HTTPS to web server"
 vpc_id      = data.aws_vpc.default-vcp.id

ingress {
   description = "HTTPS ingress"
   from_port   = 0
   to_port     = 0
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}


resource "aws_key_pair" "tf-key-pair" {
key_name = "tf-key-pair"
public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
algorithm = "RSA"
rsa_bits  = 4096
}
resource "local_file" "tf-key" {
content  = tls_private_key.rsa.private_key_pem
filename = "tf-key-pair"
}


