resource "aws_launch_template" "example-lauchconfig" {
  name          = "example-lauchtemplate"
  image_id      = var.ami_id
  instance_type = var.instance_type
  user_data     = base64encode(local.user_data_script)

  network_interfaces {
    #associate_public_ip_address = true
    security_groups = var.security_groups_ids
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "example-instance"
    }
  }

}

resource "aws_autoscaling_group" "example-autoscaling" {
  name                = "example-autoscaling"
  vpc_zone_identifier = var.vpc_subnet_ids
  launch_template {
    id      = aws_launch_template.example-lauchconfig.id
    version = "$Latest"
  }

  max_size                  = 3
  min_size                  = 2
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB" // EC2 or ELB
  force_delete              = true

  target_group_arns = var.target_group_arn

  tag {
    key                 = "Name"
    value               = "ec2_instance"
    propagate_at_launch = true
  }
}

locals {
  user_data_script = <<EOF
#!/bin/bash
apt update -y
apt install -y apache2
systemctl enable apache2
systemctl start apache2
echo "<h1>Welcome to Structure AWS with Terraform </h1>" > /var/www/html/index.html
EOF
}
