resource "aws_ssm_parameter" "ecssrv_task_size" {
  name  = "${var.prefix}-param-ecssrv-nginx-task-size"
  type  = "String"
  value = 1

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_document" "ecssrv-scale-in" {
  name            = "${var.prefix}-ssmdoc-scale-in"
  document_type   = "Automation"
  document_format = "YAML"

  content = file("${path.module}/templates/ssm/document/scale-in.yaml")
}

resource "aws_ssm_document" "ecssrv-scale-out" {
  name            = "${var.prefix}-ssmdoc-scale-out"
  document_type   = "Automation"
  document_format = "YAML"

  content = file("${path.module}/templates/ssm/document/scale-out.yaml")
}
