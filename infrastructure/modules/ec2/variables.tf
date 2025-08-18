variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to create"
  type        = string  
}

variable "subnet_id" {
  description = "The ID of the subnet in which to launch the EC2 instance"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC in which to launch the EC2 instance"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the EC2 instance"
  type        = map(string)
}