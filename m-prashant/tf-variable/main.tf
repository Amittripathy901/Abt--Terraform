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

locals {   #-->Repetetive variable or defining local variable
  owner = "Amit"
  name = "MyServer"
  }
resource "aws_instance" "myserver" {
  ami = "ami-0dee22c13ea7a9a67"
  instance_type = var.aws_instance_type    #--> var.<variable_name>

 root_block_device {
   delete_on_termination = true
   volume_size = var.ec2_config.v_size
   volume_type = var.ec2_config.v_type

   tags = merge(var.additional_tags,{
    Name = local.name
   })
 }
}