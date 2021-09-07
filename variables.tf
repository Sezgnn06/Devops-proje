variable "region" {
}
variable "ingress_ports" {
  type    = list(any)
  default = [22]
  default = [22, 80, 443]
}

variable "egress_ports" {
  type    = list(any)
  default = [8000, 8080, 8888]
}

variable "ami" {
  type = map(any)
  default = {
    us-east-2 = "ami-0443305dabd4be2bc"
    us-east-1 = "ami-0c2b8ca1dad447f8a"
    us-west-1 = "ami-04b6c97b14c54de18"
    us-west-2 = "ami-083ac7c7ecf9bb9b0"
  }
}
/*

variable "tags" {
  type    = list(any)
  default = ["my-first-ec2", "my-second-ec2", "my-third-ec2"]
}
*/

variable "instance_type" {
  default = "t2.micro"
}

variable "az" {
}

variable "protocol" {
}

variable "connection_draining" {
}
variable "cidr" {
}

variable "common_tags" {
}

variable "tags" {
  type    = list(any)
  default = ["terraform-vpc-1905", "terraform-ig-1905", "terraform-public-subnet-1905","terraform-private-subnet-1905","terraform-public-rt-1905","terraform-private-rt-1905","terraform-eip-1905","terraform-nat-gw-1905"]
  }
}
