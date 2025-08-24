region = "ap-southeast-2"

environment = "development"

vpc_cidr = "10.10.0.0/16"

public_subnet_cidr = "10.10.1.0/24"
public_subnet_cidr2 = "10.10.2.0/24"

my_ip = "103.138.49.243/32"

internet_ip = "0.0.0.0/0"

availability_zone = "ap-southeast-2a"

tags = {
  "Project" = "WebApp"
  "ManagedBy" = "Terraform"
  "Environment" = "Development"
}

web_server_ami_id = "ami-0deeb71371199f16f"