
variable "image_id" {
  type        = string
  description = "the id of AMI to user the server"
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

#dùng kiểu map để dynamic value theo key, key là 1 giá trị ở variable khác
variable "amis" {
  type = map(any)
  default = {
    "ap-southeast-1" : "ami-0453ec754f44f9a4a",
    "us-east-1" : "ami-0453ec754f44f9a5a"
  }
}
