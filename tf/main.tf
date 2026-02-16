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

    ami = "ami-04c54313c5ae6bbcb"
    instance_type = "t3.micro"

    tags ={
        Name="first_ec2"
    }
  
}
