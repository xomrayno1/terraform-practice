
variable "image_id" {
  type        = string
  description = "the id of AMI to user the server"
}

variable "key_name" {
  type        = string
  description = "key name"
}

variable "keypair_path" {
  type        = string
  description = "keypair path"
}

variable "instance_type" {
  type        = string
  description = "type of ec2 instance. Default t2.micro"
  default     = "t2.micro"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "security_group_ids" {
  type        = list(string)
  description = "security group ids"
}

variable "subnet_id" {
  type = string
}
