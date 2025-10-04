output "public_security_group_id" {
  value = aws_security_group.public-security-group.id
}

output "private_security_group_id" {
  value = aws_security_group.private-security-group.id
}

output "mariadb_security_group_id" {
  value = aws_security_group.mariadb-security-group.id
}
