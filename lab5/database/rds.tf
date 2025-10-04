
provider "aws" {
  profile = "default"
  region  = var.region
  alias   = "region"
}

resource "aws_db_subnet_group" "mariadb-subnet" { //noi rds se trien khai, chon 1 trong 2 subnet de tao rds
  name        = "mariadb-subnet"
  description = "RDS subnet group"
  subnet_ids  = var.mariadb_subnet_ids
}

resource "aws_db_parameter_group" "mariadb-parameters" {
  name        = "mariadb-parameters"
  family      = "mariadb10.5"
  description = "MariaDB parameter group"
  parameter {
    name  = "max_allowed_packet" ##save tap tin max size duoc bao nhiu
    value = 16777216
  }
}

data "aws_availability_zones" "multi_az" {
  provider = aws.region
  state    = "available"
}

resource "aws_db_instance" "mariadb" {
  allocated_storage       = 100 #100 GB of storage, gives us more IOPS than a lower number
  engine                  = "mariadb"
  engine_version          = "10.5"        # Sử dụng phiên bản MariaDB 10.5
  instance_class          = "db.t3.small" # Sử dụng loại instance db.t3.small
  identifier              = "mariadb"
  username                = var.username
  password                = var.password
  db_subnet_group_name    = aws_db_subnet_group.mariadb-subnet.name
  parameter_group_name    = aws_db_parameter_group.mariadb-parameters.name
  multi_az                = false
  vpc_security_group_ids  = var.mariadb_security_group_ids
  storage_type            = "gp2"
  backup_retention_period = 30
  availability_zone       = element(data.aws_availability_zones.multi_az.names, 0)
  skip_final_snapshot     = true # Không cần snapshot cuối cùng
  //final_snapshot_identifier = "final-mariadb-snapshot" # Đặt tên snapshot cuối cùng
  tags = {
    Name = "mariadb instance"
  }
}


