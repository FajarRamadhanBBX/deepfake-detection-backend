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

module "public_subnet2" {
  source = "../../modules/subnet"
  vpc_id = module.vpc.vpc_id
  subnet_cidr =  var.public_subnet_cidr2
  subnet_name = "${var.environment}-public-subnet-2"
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


## Securtity Group Rules
# Inbound Rules
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = module.web_server.security_group_id
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
  cidr_ipv4 = var.internet_ip
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = module.web_server.security_group_id
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"
  cidr_ipv4 = var.internet_ip
}

resource "aws_vpc_security_group_ingress_rule" "access_to_grafana" {
  security_group_id = module.web_server.security_group_id
  from_port = 3000
  to_port = 3000
  ip_protocol = "tcp"
  cidr_ipv4 = var.my_ip
}

resource "aws_vpc_security_group_ingress_rule" "access_to_prometheus" {
  security_group_id = module.web_server.security_group_id
  from_port = 9100
  to_port = 9100
  ip_protocol = "tcp"
  cidr_ipv4 = var.my_ip
}

resource "aws_vpc_security_group_ingress_rule" "manage_node_exporter" {
  security_group_id = module.web_server.security_group_id
  from_port = 9090  
  to_port = 9090  
  ip_protocol = "tcp"
  cidr_ipv4 = var.my_ip
}

resource "aws_vpc_security_group_ingress_rule" "access_remote" {
  security_group_id = module.web_server.security_group_id
  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
  cidr_ipv4 = var.my_ip
}

# Outbound Rules
# resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
#   security_group_id = module.web_server.security_group_id
#   from_port = 0
#   to_port = 0
#   ip_protocol = "-1"
#   cidr_ipv4 = var.internet_ip
# }

## Network Access Control List (NACL) Rules
resource "aws_network_acl" "nacls_for_web_server" {
  vpc_id = module.vpc.vpc_id
  # subnet_ids = module.public_subnet2.subnet_id

  ingress {
    protocol = "tcp" 
    rule_no = 100
    from_port = 22
    to_port = 22
    action = "deny"
    cidr_block = var.internet_ip
  }

  ingress {
    protocol = "tcp" 
    rule_no = 200
    from_port = 443
    to_port = 443
    action = "allow"
    cidr_block = var.internet_ip
  }

  ingress {
    protocol = "tcp" 
    rule_no = 300
    from_port = 80
    to_port = 80
    action = "allow"
    cidr_block = var.internet_ip
  }

  ingress {
    protocol = "tcp" 
    rule_no = 32766
    from_port = 0
    to_port = 65535
    action = "deny"
    cidr_block = var.internet_ip
  }

  egress {
    protocol = "tcp"
    rule_no = 100
    from_port = 0
    to_port = 65535
    action = "allow"
    cidr_block = var.internet_ip
  }

  tags = var.tags
}