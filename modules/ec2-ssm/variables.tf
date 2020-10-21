variable "prefix" {
  type    = string
  default = "test"
}

variable "instance_type" {
  type    = string
  default = "t3a.nano"
}

variable "schedule_expressions" {
  type = map(string)
  default = {
    "start_instance" = "cron(0 23 * * ? *)",
    "stop_instance"  = "cron(0 8 * * ? *)",
  }
}
