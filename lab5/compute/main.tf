
provider "aws" {
  region = var.region
}

resource "aws_instance" "demo-instance" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = var.subnet_id
  tags = {
    Name = "terraform-lab5"
  }
}

#elastic_ip
# resource "aws_eip" "aws_demo_eip" {
#   instance = aws_instance.demo-instance.id
# }

resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "extra volume data"
  }

}

resource "aws_volume_attachment" "ebs_volume-1-attach" {
  instance_id = aws_instance.demo-instance.id
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  device_name = "/dev/xvdh" //chỉ định thiết bị trên instance mà volume sẽ được gắn vào
}
