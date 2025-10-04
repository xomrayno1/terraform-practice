
provider "aws" {
  region = var.region
}

resource "aws_instance" "demo-instance" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name = "terraform-lab4"
  }
}

resource "aws_eip" "aws_demo_eip" {
  instance = aws_instance.demo-instance.id
}
