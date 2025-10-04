output "public_security_group_id" {
  value = aws_security_group.public-security-group.id
}

output "private_security_group_id" {
  value = aws_security_group.private-security-group.id
}

output "public_security_group_name" {
  value = aws_security_group.public-security-group.name
}

output "loadbalancer_security_group_id" {
  value = aws_security_group.loadbalancer-security-group.id
}


output "asg_security_group_id" {
  value = aws_security_group.asg-security-group.id
}

output "asg_security_group_name" {
  value = aws_security_group.asg-security-group.name
}
