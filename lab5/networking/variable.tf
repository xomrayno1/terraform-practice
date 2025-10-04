variable "region" {
  type = string
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
