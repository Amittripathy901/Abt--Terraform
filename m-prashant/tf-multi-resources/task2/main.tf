terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.72.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

locals {
  project = "task-02"
}

resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"  #count.index -->starts with 0, then 1, 2 3 .... so on
  count = 2   #-->this block will run two times
  tags = {
     Name = "${local.project}-subnet-${count.index}"
  }
}

#Creating ec2 instance
resource "aws_instance" "main" {
  ami = "ami-04a37924ffe27da53"
  instance_type = "t2.micro"
  count = 4
  subnet_id = element(aws_subnet.main[*].id, count.index % length(aws_subnet.main))
  #0%2 = 0
  #1%2 = 1
  #2%2 = 0
  #3%2 = 1


  tags = {
    Name = "${local.project}-Instance-${count.index}"
  }

}
output "aws_subnet_id" {
  #value = aws_subnet.main[0].id         #-->main has a list so output based on indexing 
  value = aws_subnet.main[1].id         #-->main has a list so output based on indexing 
}