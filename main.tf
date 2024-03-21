terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.41"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-0d7a109bf30624c99"
  instance_type = "t2.micro"
  key_name      = "armankey"
  
  tags = {
    Name = "MyEC2Instance"
  }
}

