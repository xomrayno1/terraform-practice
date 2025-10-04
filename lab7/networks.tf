resource "aws_vpc" "vpc_master" {
  provider             = aws.region-master
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "master-vpc-jekins"
  }
}

resource "aws_vpc" "vpc_worker" {
  provider             = aws.region-worker
  cidr_block           = "192.168.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "worker-vpc-jekins"
  }
}

resource "aws_internet_gateway" "igw-master" {
  provider = aws.region-master
  vpc_id   = aws_vpc.vpc_master.id
}

resource "aws_internet_gateway" "igw-worker" {
  provider = aws.region-worker
  vpc_id   = aws_vpc.vpc_worker.id
}

#get all az state = 'available' in vpc 
data "aws_availability_zones" "azs-master" {
  provider = aws.region-master
  state    = "available"
}

data "aws_availability_zones" "azs-worker" {
  provider = aws.region-worker
  state    = "available"
}

#create subnet #1 in us-east-1
#element: element retrieves a single element from a list.
resource "aws_subnet" "subnet_1_master" {
  provider          = aws.region-master
  availability_zone = element(data.aws_availability_zones.azs-master.names, 0)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.1.0/24"
}

resource "aws_subnet" "subnet_2_master" {
  provider          = aws.region-master
  availability_zone = element(data.aws_availability_zones.azs-master.names, 1)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.2.0/24"
}

resource "aws_subnet" "subnet_1_worker" {
  provider          = aws.region-worker
  availability_zone = element(data.aws_availability_zones.azs-worker.names, 0)
  vpc_id            = aws_vpc.vpc_worker.id
  cidr_block        = "192.168.0.0/24"
}

resource "aws_subnet" "subnet_2_worker" {
  provider          = aws.region-worker
  availability_zone = element(data.aws_availability_zones.azs-worker.names, 1)
  vpc_id            = aws_vpc.vpc_worker.id
  cidr_block        = "192.168.1.0/24"
}

resource "aws_vpc_peering_connection" "useast1-uswest1" {
  provider    = aws.region-master
  vpc_id      = aws_vpc.vpc_master.id
  peer_region = var.region-worker
  peer_vpc_id = aws_vpc.vpc_worker.id
}

#region-worker sẽ chấp nhận connection peering  trước đó
resource "aws_vpc_peering_connection_accepter" "accept_peering" {
  provider                  = aws.region-worker
  vpc_peering_connection_id = aws_vpc_peering_connection.useast1-uswest1.id
  auto_accept               = true
}

resource "aws_route_table" "internet_route_master" {
  provider = aws.region-master
  vpc_id   = aws_vpc.vpc_master.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-master.id
  }

  route { #nếu đi đến ip 192.168.1.0/24 thì đi thông qua peering 
    cidr_block                = "192.168.1.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.useast1-uswest1.id
  }

  #bỏ qua các thay đổi với bảng định tuyến này, hợp ích với case route table bị thay đổi ngoài Terraform.
  #ví dụ như aws console.
  lifecycle {
    ignore_changes = all
  }

  tags = {
    Name = "Master-Region-RT"
  }

}

#route nhiều subnet trong vpc với routetable
resource "aws_main_route_table_association" "set-master-default-rt-assoc" {
  provider       = aws.region-master
  route_table_id = aws_route_table.internet_route_master.id
  vpc_id         = aws_vpc.vpc_master.id
}

resource "aws_route_table" "internet_route_worker" {
  provider = aws.region-worker
  vpc_id   = aws_vpc.vpc_worker.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-worker.id
  }

  route { #nếu đi đến ip 192.168.1.0/24 thì đi thông qua peering 
    cidr_block                = "10.0.1.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.useast1-uswest1.id
  }

  lifecycle { #bỏ qua các thay đổi với bảng định tuyến này, hợp ích với case route table bị thay đổi ngoài Terraform.
    ignore_changes = all
  }

  tags = {
    Name = "Worker-Region-RT"
  }

}

#route nhiều subnet trong vpc với routetable
resource "aws_main_route_table_association" "set-worker-default-rt-assoc" {
  provider       = aws.region-worker
  route_table_id = aws_route_table.internet_route_worker.id
  vpc_id         = aws_vpc.vpc_worker.id
}


