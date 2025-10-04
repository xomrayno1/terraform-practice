terraform {
  required_version = ">= 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "networking" {
  source = "./networking"

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  cidr            = var.cidr
  region          = var.region
}
