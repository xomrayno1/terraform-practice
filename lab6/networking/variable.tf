variable "azs" {
  type = list(string)
}

variable "cidr" {
  type = string
}

variable "region" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

