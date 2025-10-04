variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "security_groups_ids" {
  type = list(string)
}

variable "vpc_subnet_ids" {
  type = list(string)
}

variable "security_groups_names" {
  type = list(string)
}

variable "target_group_arn" {
  type = list(string)
}
