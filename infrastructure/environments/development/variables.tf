variable "region" {
  description = "AWS region where the resources will be created"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., development, staging, production)"
  type = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the public subnet"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "web_server_ami_id" {
  description = "AMI ID for the web server EC2 instance"
  type        = string
}