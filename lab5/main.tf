
provider "aws" {
  region = var.region
}

resource "aws_key_pair" "tamnc-keypair" {
  key_name   = var.key_name
  public_key = file(var.keypair_path)
}

module "security" {
  source = "./security"
  region = var.region
  vpc_id = module.networking.vpc_id
}

module "compute" {
  source             = "./compute"
  region             = var.region
  key_name           = var.key_name
  keypair_path       = var.keypair_path
  image_id           = var.amis[var.region]
  subnet_id          = module.networking.public_subnet_id
  instance_type      = var.instance_type
  security_group_ids = [module.security.public_security_group_id]
}

module "networking" {
  source              = "./networking"
  region              = var.region
  cidr_block          = var.cidr_block
  public_subnet_ips   = var.public_subnet_ips
  private_subnet_ips  = var.private_subnet_ips
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
}

module "database" {
  source                     = "./database"
  username                   = var.username
  password                   = var.password
  region                     = var.region
  mariadb_security_group_ids = [module.security.mariadb_security_group_id]
  mariadb_subnet_ids         = [module.networking.private_subnet_1_id, module.networking.private_subnet_2_id]
}
