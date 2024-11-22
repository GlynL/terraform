terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0e8d228ad90af673b"
  instance_type = "t2.micro"

  # Associate the instance with the SSH key pair
  key_name = aws_key_pair.my_key.key_name  # Use the key pair created above


  tags = {
    Name = "testing"
  }
}

resource "aws_key_pair" "my_key" {
  key_name   = "my-ec2-key"
  public_key = var.ssh_key_public
}
