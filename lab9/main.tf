
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

module "networking" {
  source              = "./networking"
  region              = var.region
  cidr_block          = var.cidr_block
  public_subnet_ips   = var.public_subnet_ips
  private_subnet_ips  = var.private_subnet_ips
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
}


module "alb" {
  source              = "./alb"
  security_groups_ids = [module.security.loadbalancer_security_group_id]
  subnets_ids         = [module.networking.public_subnet_id, module.networking.public_subnet_2_id]
  vpc_id              = module.networking.vpc_id
}

module "autoscaling" {
  source                = "./autoscaling"
  instance_type         = var.instance_type
  security_groups_ids   = [module.security.asg_security_group_id]
  security_groups_names = [module.security.asg_security_group_name]
  vpc_subnet_ids        = [module.networking.private_subnet_1_id, module.networking.private_subnet_2_id]
  ami_id                = var.amis[var.region]
  target_group_arn      = [module.alb.target_group_arn]
}

