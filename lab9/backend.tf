terraform {
  required_version = ">=0.0.12.0"
  required_providers {
    aws = ">=3.0.0"
  }

  backend "s3" { //save state s3
    region  = "us-east-1"
    profile = "default"
    key     = "terraformstatefile-lab9"
    bucket  = "terraformbucket-1999"
  }
}
