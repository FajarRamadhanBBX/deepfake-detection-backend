module "vpc" {
  source = "../../modules/vpc"
  vpc_cidr = var.vpc_cidr
  environment_name = var.environment
  tags = var.tags
}

module "public_subnet" {
  source = "../../modules/subnet"
  vpc_id = module.vpc.vpc_id
  subnet_cidr =  var.public_subnet_cidr
  subnet_name = "${var.environment}-public-subnet-1"
  availability_zone = var.availability_zone
  tags = var.tags
}

module "web_server" {
  source = "../../modules/ec2"
  instance_name = "${var.environment}-web-server"
  ami_id = var.web_server_ami_id
  subnet_id = module.public_subnet.subnet_id
  vpc_id = module.vpc.vpc_id
  instance_type = "t3.micro"
  tags = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = module.web_server.security_group_id
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = module.web_server.security_group_id
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"
  cidr_ipv4 = "0.0.0.0/0"
}