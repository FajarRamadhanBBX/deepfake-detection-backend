output "instance_id" {
  value = aws_instance.main.id
  description = "The ID of the EC2 instance"
}

output "security_group_id" {
  value = aws_security_group.instance_sg.id
  description = "The ID of the security group for the EC2 instance"
}

output "ip_public" {
  value = aws_instance.main.public_ip
  description = "The public IP address of the EC2 instance"
}