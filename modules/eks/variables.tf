variable "prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}


variable "subnet_id_list" {
  type = list(string)
}

variable "private_subnet_id_list" {
  type = list(string)
}
