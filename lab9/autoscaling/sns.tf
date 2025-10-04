resource "aws_sns_topic" "example-cpu-sns" {
  name         = "sg-cpu-sns"
  display_name = "example ASG SNS topic"
}

resource "aws_autoscaling_notification" "example-notify" {
  group_names = [aws_autoscaling_group.example-autoscaling.name]
  topic_arn   = aws_sns_topic.example-cpu-sns.arn
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR"
  ]
}
