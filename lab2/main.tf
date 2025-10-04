
provider "aws" {
  region = var.region
}

resource "aws_key_pair" "tamnc-keypair" {
  key_name   = "tamnc-keypair_name"
  public_key = file("/Users/tamnc/Documents/keypair/terraform/tamnc-key.pub")
}

resource "aws_instance" "demo-instance" {
  ami           = var.amis[var.region]
  instance_type = var.instance_type
  key_name      = aws_key_pair.tamnc-keypair.key_name
  tags = {
    Name = "terraform-lab1"
  }
  vpc_security_group_ids = [aws_security_group.test-security-group.id]
}

resource "aws_security_group" "test-security-group" {
  name        = "test-security-group-name"
  description = "allow access"
  vpc_id      = "vpc-0f81ea992b18513f7"
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description      = "for all outgoing traffics"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

  }

  tags = {
    Name = "terraform-lab1"
  }
}
