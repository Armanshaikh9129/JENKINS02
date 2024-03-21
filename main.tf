terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
       version = "5.40.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
  key_name      = "armankey"
  
  tags = {
    Name = "MyEC2Instance"
  }
}

