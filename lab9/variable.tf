variable "region" {
  type    = string
  default = "us-east-1"
}
variable "instance_type" {
  type        = string
  description = "type of ec2 instance. Default t2.micro"
  default     = "t2.micro"
}

#dùng kiểu map để dynamic value theo key, key là 1 giá trị ở variable khác
variable "amis" {
  type = map(any)
}

variable "key_name" {
  type        = string
  description = "key name"
}

variable "keypair_path" {
  type        = string
  description = "keypair path"
}

variable "cidr_block" {
  type = string
}

variable "public_subnet_ips" {
  type = list(string)
}

variable "availability_zone_1" {
  type = string
}

variable "availability_zone_2" {
  type = string
}

variable "private_subnet_ips" {
  type = list(string)
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}
