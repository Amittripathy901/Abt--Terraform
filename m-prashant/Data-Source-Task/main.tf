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

# VPC
data "aws_vpc" "name" {
  tags = {
    ENV  = "PROD"
    Name = "my-vpc"
  }
}

output "vpc_id" {
  value = data.aws_vpc.name.id
}

# Subnet ID
data "aws_subnet" "name" {
  vpc_id = data.aws_vpc.name.id
  tags = {
    ENV  = "Prod"
    Name = "Private-Subnet"
  }
}

output "subnet_id" {
  value = data.aws_subnet.name.id
}

# Security Group
data "aws_security_group" "name" {
  tags = {
    mywebserver = "http"
  }
}

output "security_group" {
  value = data.aws_security_group.name.id
}

# AMI
data "aws_ami" "name" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

output "aws_ami" {
  value = data.aws_ami.name.id
}

# Availability Zone
data "aws_availability_zones" "names" {
  state = "available"
}

output "aws_zones" {
  value = data.aws_availability_zones.names.names
}

# Region
data "aws_region" "name" {}

output "region_name" {
  value = data.aws_region.name.name
}

# Account Details
data "aws_caller_identity" "name" {}

output "caller_info" {
  value = data.aws_caller_identity.name
}

# EC2 Instance
resource "aws_instance" "MyServer" {
  ami             = data.aws_ami.name.id
  instance_type   = "t2.micro"
  subnet_id       = data.aws_subnet.name.id
  security_groups = [data.aws_security_group.name.id]

  tags = {
    Name = "Sample Server"
  }
}