resource "aws_alb" "alb_load_balancer" {
  name               = "loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups_ids
  subnets            = var.subnets_ids

  tags = {
    Name = "Terraform"
  }

}

resource "aws_alb_target_group" "alb_target_group" {
  name        = "EC2TargetGroup1"
  port        = 80
  target_type = "instance"
  vpc_id      = var.vpc_id
  protocol    = "HTTP"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_alb_listener" "aws_alb_listener" {
  load_balancer_arn = aws_alb.alb_load_balancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }


}
