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
  # key_name = aws_key_pair.my_key.key_name  # could be creating one rather htan using mine
  key_name = "ssh-key-pub" # use existing - can't duplicate creating

  # probably shouldn't be hardcoded here
  vpc_security_group_ids = ["sg-02aaa1827e61fe20a"]

  tags = {
    Name = "testing"
  }
}

variable "ssh_key_public" {
  description = "The public SSH key to use for the EC2 instance"
  type        = string
}

variable "ssh_key_private" {
  description = "The private SSH key to use for the EC2 instance"
  type        = string
}

# resource "aws_key_pair" "my_key" {
#   key_name   = "ssh-key-pub"
#   public_key = var.ssh_key_public
# }
