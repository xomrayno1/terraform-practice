output "VPC_ID_US_EAST_1" {
  value = aws_vpc.vpc_master.id
}

output "VPC_ID_US_WEST_1" {
  value = aws_vpc.vpc_worker
}

output "PEERING_CONNECTION_ID" {
  value = aws_vpc_peering_connection.useast1-uswest1.id
}

output "jenkins-Master-Node-Public-IP" {
  value = aws_instance.jenkins-master.public_ip
}

output "jenkins-Worker-Node-Public-IPs" {
  value = {
    for instance in aws_instance.jenkins-worker :
    instance.id => instance.public_ip
  }
}
/*
{
  "i-0abcd1234efgh5678" = "54.123.45.67"
  "i-0abcd1234efgh5679" = "54.123.45.68"
}
*/
