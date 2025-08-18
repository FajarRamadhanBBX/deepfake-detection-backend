variable "vpc_id" {
  description = "ID of the VPC where the subnet will be created"
  type = string
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type = string
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type = string
}

variable "tags" {
  description = "Tags to apply to the subnet"
  type = map(string)
  default = {}
}