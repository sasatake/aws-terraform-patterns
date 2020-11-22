resource "aws_ssm_parameter" "ecssrv_task_size" {
  name  = "${var.prefix}-param-ecssrv-nginx-task-size"
  type  = "String"
  value = 1

  lifecycle {
    ignore_changes = [value]
  }
}
