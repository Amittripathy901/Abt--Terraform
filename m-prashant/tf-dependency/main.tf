terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.72.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "main" {
  name = "my-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "main" {
  ami           = "ami-04a37924ffe27da53"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.main.id]
  depends_on             = [aws_security_group.main]

  lifecycle {
    #create_before_destroy = true
    #prevent_destroy = true #-->Prevents destroying of resources
    replace_triggered_by = [ aws_security_group.main, aws_security_group.main.ingress ]
  }
}
