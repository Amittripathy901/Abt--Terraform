resource "aws_security_group" "Nginx-SG" {
  vpc_id = aws_vpc.my_vpc.id
  
  #Inbound rule for http
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  #Outbound rule for http
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1" #-->Applicable for all ports
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Nginx-SG"
  }
}