
resource "aws_security_group" "lb-sg" {
  provider    = aws.region-master
  name        = "lb-sg"
  description = "Allow 443 and traffic to jenkins SG"
  vpc_id      = aws_vpc.vpc_master.id
  ingress {
    from_port   = 443
    to_port     = 443
    description = "port 443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    description = "allow 80 from anywhere for redirection"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_security_group" "jenkins-sg-master" {
  provider    = aws.region-master
  name        = "jenkins-sg-master"
  description = "Allow TCP/8080 & TCP/22"
  vpc_id      = aws_vpc.vpc_master.id
  ingress {
    from_port   = 22
    to_port     = 22
    description = "Allow 22 from our public IP"
    protocol    = "tcp"
    cidr_blocks = [var.external_id]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    description = "allow anyone on port 8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    description = "allow traffic from us-weast-1"
    protocol    = "-1"
    cidr_blocks = ["192.168.1.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "jenkins-sg-worker" {
  provider    = aws.region-worker
  name        = "jenkins-sg-worker"
  description = "Allow TCP/8080 & TCP/22"
  vpc_id      = aws_vpc.vpc_worker.id
  ingress {
    from_port   = 22
    to_port     = 22
    description = "Allow 22 from our public IP"
    protocol    = "tcp"
    cidr_blocks = [var.external_id]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    description = "allow traffic from us-weast-1"
    protocol    = "-1"
    cidr_blocks = ["10.0.1.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
