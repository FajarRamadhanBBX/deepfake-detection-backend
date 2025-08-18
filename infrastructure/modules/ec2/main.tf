resource "aws_security_group" "instance_sg" {
  name = "${var.instance_name}-sg"
  vpc_id = var.vpc_id
  description = ("Security group for the EC2 instance")

  tags = merge(
    var.tags,
    {
        name = "${var.instance_name}-sg",
    }
  )

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "main" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id

  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  associate_public_ip_address = true
  tags = merge(
    var.tags,
    {
      Name = var.instance_name
    }
  )
}