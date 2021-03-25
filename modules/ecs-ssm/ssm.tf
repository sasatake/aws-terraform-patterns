resource "aws_ssm_parameter" "ecssrv_task_size" {
  name  = "${var.prefix}-param-ecssrv-nginx-task-size"
  type  = "String"
  value = 1

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_document" "ecssrv_scale_in" {
  name            = "${var.prefix}-ssmdoc-ecssrv_scale_in"
  document_type   = "Automation"
  document_format = "YAML"
  content         = file("${path.module}/templates/ssm/document/ecs-scale-in.yaml")
}

resource "aws_ssm_document" "ecssrv_scale_out" {
  name            = "${var.prefix}-ssmdoc-ecssrv_scale_out"
  document_type   = "Automation"
  document_format = "YAML"
  content         = file("${path.module}/templates/ssm/document/ecs-scale-out.yaml")
}
