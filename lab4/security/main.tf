provider "aws" {
  region = var.region
}

resource "aws_security_group" "public-security-group" {
  name        = "public-security-group-name"
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
    Name = "terraform-lab4"
  }
}

resource "aws_security_group" "private-security-group" {
  name        = "private-security-group-name"
  description = "allow access port 80, 3306"
  vpc_id      = "vpc-0f81ea992b18513f7"
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public-security-group.id]
    description     = "Allow public security group access port 80 HTTP"
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.public-security-group.id]
    description     = "Allow public security group access port 3306 RDS"
  }

  egress {
    description      = "For all outgoing traffics"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "terraform-lab4"
  }
}
