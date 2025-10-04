variable "region" {
  type    = string
  default = "us-east-1"
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}

variable "mariadb_security_group_ids" {
  type = list(string)
}

variable "mariadb_subnet_ids" {
  type = list(string)
}
