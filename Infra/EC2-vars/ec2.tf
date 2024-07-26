resource "aws_instance" "web" { #aws_instance==EC2, Web is this block name(uerDefined)
  ami           = var.amiID #Amazon Linux 2
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.security-group-allow-all.id]
  key_name = aws_key_pair.tf-key-pair.key_name

  tags = {
    Name = var.ec2_name["name"]
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
   cidr_blocks = var.cidr_blocks
 }

egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = [var.cidr_blocks[0]]
 }
}


resource "aws_key_pair" "tf-key-pair" {
key_name = var.key_pair_name
public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
algorithm = "RSA"
rsa_bits  = 4096
}
resource "local_file" "tf-key" {
content  = tls_private_key.rsa.private_key_pem
filename = var.key_pair_name
}


