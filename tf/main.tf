terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.32.1"
    }
  }
}

provider "aws" {

  # Configuration options
    region ="ap-south-1"

}

resource "aws_instance" "ec2server" {

    ami = "ami-0ffef61f6dc37ae89"
    instance_type = "t3.micro"
    key_name = aws_key_pair.ec2key.key_name
    security_groups = [aws_security_group.my-sg.name]
  

    root_block_device {
      volume_size = 15
      volume_type = "gp3"
    }

    tags ={
        Name="first_ec2"
    }
  
}

resource "aws_key_pair" "ec2key" {
      key_name = "tf-ec2key"
      public_key = file("tf-ec2-key.pub")

}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "my-sg" {
  name        = "automate-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id

  ingress {

    to_port = 22
    from_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH open"
  }

  ingress {
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol= "tcp"
    description = "http open"
  }
  egress {
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"
    description = "Allow access opened"
  }

  tags = {
    Name = "automate-sg"
  }
}

