
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region = "eu-north-1"
}

resource "aus_security_group" "web_app" {
  name = "web_app"
  description = "security group"
  ingress {
    grom_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  ingress {
    grom_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  engress {
    grom_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "web_app"
  }
}

resource "aws_instance" "webapp_instance" {
  ami = "ami-0669b163befffbdfc"
  instance_type = "t2.micro"
  tags = {
    Name = "webapp_instance"
  }
}

output "instance_public_ip" {
  value = aws_instance.webapp_instance.public_ip
  sensitive = true
}
