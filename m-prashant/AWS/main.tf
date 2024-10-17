variable "region" {
  description = "Value of Region"
  type = string
  default = "ap-south-1"
}



terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.72.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "MyServer" {
  ami = "ami-0dee22c13ea7a9a67"
  instance_type = "t2.micro"

 tags = {
   Name: "Terraform Server"
 }
  
}