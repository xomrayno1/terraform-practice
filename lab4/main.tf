
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
}

module "compute" {
  source             = "./compute"
  region             = var.region
  key_name           = var.key_name
  keypair_path       = var.keypair_path
  image_id           = var.amis[var.region]
  instance_type      = var.instance_type
  security_group_ids = [module.security.public_security_group_id]
}
