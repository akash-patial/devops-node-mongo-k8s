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

resource "aws_instance" "" {

    ami = ""
    instance_type = "t3.micro"

    tags ={
        Name="first_ec2"
    }
  
}
