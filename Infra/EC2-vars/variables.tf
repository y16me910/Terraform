variable "amiID" {
    type = string
    description = "type of OS"
    default = "ami-0d7e17c1a01e6fa40"
}

variable "instance_type" {
    type = string
    description = "size of VM"
    default = "t3.micro"
}

variable "key_pair_name" {
    type = string
    description = "name of the key pair for EC2"
    default = "tf-key-pair"
}

variable "cidr_blocks" {
    type = list(string)
    description = "cidr blocks of security group"
    default = ["0.0.0.0/0"]
}

variable "ec2_name" {
    type = map(string)
    description = "name of the ec2 instance"
    default = {
        name = "EC2-Terraform"
    }
}