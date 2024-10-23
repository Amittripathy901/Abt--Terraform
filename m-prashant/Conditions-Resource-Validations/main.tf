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

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
}
resource "aws_instance" "main" {
  ami           = "ami-04a37924ffe27da53"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private.id
  associate_public_ip_address = false
  #vpc_security_group_ids = [aws_security_group.main.id]
  depends_on             = [aws_security_group.main]

  lifecycle {
    #create_before_destroy = true
    #prevent_destroy = true #-->Prevents destroying of resources
    #replace_triggered_by = [ aws_security_group.main, aws_security_group.main.ingress ]


    precondition {
      condition = aws_security_group.main.id != ""
      error_message = "Security group ID must not be blank"
    }

    postcondition {
      condition = self.public_ip != ""
      error_message = "Public IP is not present"
    }

  }
}
