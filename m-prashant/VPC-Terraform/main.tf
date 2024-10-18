terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.72.0"
    }
   random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

#Create a VPC

resource "aws_vpc" "my-VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "My_VPC"
  }
}

#Public Subnet
resource "aws_subnet" "Public-Subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.my-VPC.id
  tags = {
    Name = "Public-Subnet"
  }
}

#Private Subnet
resource "aws_subnet" "Private-Subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.my-VPC.id
  tags = {
    Name = "Private-Subnet"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-VPC.id
  tags = {
    Name = "my-igw"
  }
}

#Routing Table
resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-VPC.id

  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
}

#Route Table Association
resource "aws_route_table_association" "public-rt" {
  route_table_id = aws_route_table.my-rt.id
  subnet_id = aws_subnet.Public-Subnet.id
}


#Creating EC2 in VPC
resource "aws_instance" "MyServer" {
  ami = "ami-0dee22c13ea7a9a67"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.Public-Subnet.id

 tags = {
   Name: "My-VPC-Server"
 }
  
}