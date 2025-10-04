# terraform-practice

#generate keypair local <br>

ssh-keygen -t rsa -b 4096 -C "tamnc@imt-soft.com" <br>

#cmd terraform <br>

terraform init <br>
terraform plan <br>
terraform plan --var-file "terraform-dev.tfvars" #chỉ định file value là terraform-dev.tfvars thay vì mặc định là terraform.tfvars <br>
terraform apply <br>
terraform destroy<br>

create module nhanh<br>
https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest <br>

#format code <br>
terraform fmt <br>

terraform validate <br>

data: sử dụng để truy vấn các tài nguyên đã có sẵn<br>
resource: tài nguyên trong aws <br>
variable: biến param aws <br>
provider: tạo ra các provider sẽ sử dụng trong terraform <br>
