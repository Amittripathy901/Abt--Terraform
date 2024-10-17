terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.72.0"
    }   
  }
  backend "s3" {
    bucket = "demo-bucket-7de1ff7b85cdbf2d"
    key = "backend.tfstate01"
    region = "ap-south-1"
  }
}
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "MyServer" {
  ami = "ami-0dee22c13ea7a9a67"
  instance_type = "t2.micro"

 tags = {
   Name: "Sample Server"
 }
  
}