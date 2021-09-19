variable "prefix" {
  type    = string
  default = "test"
}

variable "instance_type" {
  type    = string
  default = "t3a.nano"
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "subnet_az_name" {
  type = string
}
