resource "aws_cloudwatch_event_rule" "ecssrv_scale_in" {
  name                = "${var.prefix}-events-ecssrv_scale_in"
  schedule_expression = "cron(0 0 ? * MON-FRI *)"
}

resource "aws_cloudwatch_event_rule" "ecssrv_scale_out" {
  name                = "${var.prefix}-events-ecssrv_scale_out"
  schedule_expression = "cron(0 9 ? * MON-FRI *)"
}

resource "aws_cloudwatch_event_target" "ecssrv_scale_in" {
  rule      = aws_cloudwatch_event_rule.ecssrv_scale_in.name
  arn       = replace(aws_ssm_document.ecssrv_scale_in.arn, "document/", "automation-definition/")
  target_id = aws_ssm_document.ecssrv_scale_in.name
  role_arn  = aws_iam_role.ssm_automation.arn
  input     = <<EOF
    {
      "ClusterName": "${split("/", aws_ecs_cluster.nginx.id)[1]}",
      "ServiceName": "${aws_ecs_service.nginx.name}"
    }
  EOF
}

resource "aws_cloudwatch_event_target" "ecssrv_scale_out" {
  rule      = aws_cloudwatch_event_rule.ecssrv_scale_out.name
  arn       = replace(aws_ssm_document.ecssrv_scale_out.arn, "document/", "automation-definition/")
  target_id = aws_ssm_document.ecssrv_scale_out.name
  role_arn  = aws_iam_role.ssm_automation.arn
  input     = <<EOF
    {
      "ClusterName": "${split("/", aws_ecs_cluster.nginx.id)[1]}",
      "ServiceName": "${aws_ecs_service.nginx.name}"
    }
  EOF
}
