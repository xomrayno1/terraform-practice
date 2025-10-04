instance_type = "t3.micro"
amis = {
  "ap-southeast-1" : "ami-0453ec754f44f9a4a",
  "us-east-1" : "ami-0e2c8caa4b6378d8c"
}
region              = "us-east-1"
key_name            = "terraform-tamnc-keypair"
keypair_path        = "/Users/tamnc/Documents/keypair/terraform/tamnc-key.pub"
cidr_block          = "10.0.0.0/16"
public_subnet_ips   = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_ips  = ["10.0.10.0/24", "10.0.20.0/24"]
availability_zone_1 = "us-east-1a"
availability_zone_2 = "us-east-1b"

username = "tamnc"
password = "tamnc12345"

