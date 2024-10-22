terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.72.1"
    }
  }
}

data "aws_ami" "name" {
  most_recent = true
  owners = ["amazon"]
}
output "aws_ami" {
  value = data.aws_ami.name.id
}

provider "aws" {
  region = "ap-south-1"
}

#Security Group
data "aws_security_group" "name" {
  tags = {
   # mywebserver = "http"
  }
}

output "security_group" {
  value = data.aws_security_group.name.id
}

#VPC
data "aws_vpc" "name" {
  tags = {
    #ENV = "PROD"
    #Name = "my-vpc"
  }
}
output "vpc_id" {
  value = data.aws_vpc.name.id
}

#Availability Zone
data "aws_availability_zones" "names" {
  state = "available"
}

output "aws_zones" {
  value = data.aws_availability_zones.names
}

#Region
data "aws_region" "name" { 
}

output "region_name" {
  value = data.aws_region.name
}

#Account Details
data "aws_caller_identity" "name" {
}
output "caller_info" {
  value = data.aws_caller_identity.name
}



resource "aws_instance" "MyServer" {
  ami = data.aws_ami.name.id
  instance_type = "t2.micro"

 tags = {
   Name: "Sample Server"
 }
  
}