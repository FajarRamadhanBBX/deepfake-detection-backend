output "subnet_id" {
  description = "The IDs of the subnets"
  value = aws_subnet.main[*].id
}