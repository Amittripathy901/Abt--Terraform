
# EC2 instance For Nginx setup
resource "aws_instance" "nginxserver" {
  ami                         = "ami-0dee22c13ea7a9a67"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.Nginx-SG.id] #-->Added security group
  associate_public_ip_address = true

  user_data = <<-EOF
            #!/bin/bash
            sudo apt install nginx -y
            sudo systemctl start nginx
            sudo systemctl enable nginx
            EOF

  tags = {
    Name = "NginxServer"
  }
}