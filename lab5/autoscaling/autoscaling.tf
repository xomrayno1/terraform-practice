resource "aws_launch_configuration" "example-lauchconfig" {
  name_prefix     = "example-lauchconfig"
  image_id        = var.ami_id
  instance_type   = var.instance_type
  security_groups = var.security_groups_ids
}


resource "aws_autoscaling_group" "example-autoscaling" {
  name                      = "example-autoscaling"
  vpc_zone_identifier       = var.vpc_subnet_ids
  launch_configuration      = aws_launch_configuration.example-lauchconfig
  max_size                  = 3
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC"
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2_instance"
    propagate_at_launch = true
  }
}
