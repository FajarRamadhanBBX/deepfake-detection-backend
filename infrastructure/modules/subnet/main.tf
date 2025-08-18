resource "aws_subnet" "main" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr
  availability_zone = var.availability_zone
  
  tags = merge(
    {
      Name = var.subnet_name
    },
    var.tags
  )
}