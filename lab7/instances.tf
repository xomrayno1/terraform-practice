#get linux ami id using AWS Systems Manager Parameter Store in us-east-1
data "aws_ssm_parameter" "linuxAMIMaster" {
  provider = aws.region-master
  name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

#get linux ami id using AWS Systems Manager Parameter Store in us-west-1
data "aws_ssm_parameter" "linuxAMIWorker" {
  provider = aws.region-worker
  name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_key_pair" "master-key" {
  provider   = aws.region-master
  key_name   = "master-key"
  public_key = file("/Users/tamnc/Documents/keypair/terraform/tamnc-key.pub")
}

resource "aws_key_pair" "worker-key" {
  provider   = aws.region-worker
  key_name   = "worker-key"
  public_key = file("/Users/tamnc/Documents/keypair/terraform/tamnc-key.pub")
}

#create ec2 in us-east-1
resource "aws_instance" "jenkins-master" {
  provider                    = aws.region-master
  ami                         = data.aws_ssm_parameter.linuxAMIMaster.value
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.master-key.key_name
  associate_public_ip_address = true #gan 1 ip public
  security_groups             = [aws_security_group.jenkins-sg-master.id]
  subnet_id                   = aws_subnet.subnet_1_master.id
  tags = {
    Name = "jenkins_master_tf"
  }
  //*đảm bảo resource này được tạo ra sau khi aws_main_route_table_association đc tạo
  depends_on = [aws_main_route_table_association.set-master-default-rt-assoc]
}

#create ec2 in us-west-1
resource "aws_instance" "jenkins-worker" {
  provider                    = aws.region-worker
  count                       = var.worker-count
  ami                         = data.aws_ssm_parameter.linuxAMIWorker.value
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.worker-key.key_name
  associate_public_ip_address = true #gan 1 ip public
  security_groups             = [aws_security_group.jenkins-sg-worker.id]
  subnet_id                   = aws_subnet.subnet_1_worker.id
  tags = {
    Name = join("_", ["jenkins_worker_tf", count.index + 1])
  }
  //*đảm bảo resource này được tạo ra sau khi aws_main_route_table_association, aws_instance.jenkins-master đc tạo
  depends_on = [aws_main_route_table_association.set-worker-default-rt-assoc, aws_instance.jenkins-master]
}

