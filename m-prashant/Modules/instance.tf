module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.1"


  name = "Single-Instance"

  ami = "ami-0dee22c13ea7a9a67"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Name        = "Module-Instance"
    Environment = "Dev"
  }
}
