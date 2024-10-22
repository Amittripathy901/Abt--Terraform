output "instance_public_ip" {
  description = "The Public IP address of the Ec2 Instance"
  value = aws_instance.nginxserver.public_ip
}

output "instance_url" {
  description = "The URL to access the Nginx server"
  value = "http://${aws_instance.nginxserver.public_ip}"
}