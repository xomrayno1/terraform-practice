output "instance_private_id" {
  value = aws_instance.demo-instance.private_ip
}

output "instance_public_id" {
  value = aws_instance.demo-instance.public_ip
}
