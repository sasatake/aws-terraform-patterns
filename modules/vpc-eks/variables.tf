variable "prefix" {
  type = string
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_az_list" {
  type    = list(string)
  default = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}
