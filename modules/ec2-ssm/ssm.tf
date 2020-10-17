resource "aws_ssm_association" "start_instance" {
  name                = data.aws_ssm_document.start_instance.name
  schedule_expression = var.schedule_expressions["start_instance"]
  compliance_severity = "MEDIUM"
  parameters = {
    AutomationAssumeRole = aws_iam_role.ssm_automation.arn
  }
  targets {
    key = "ParameterValues"
    values = [
      "aws_instance.web.id"
    ]
  }
  automation_target_parameter_name = "InstanceId"
}

resource "aws_ssm_association" "stop_instance" {
  name                = data.aws_ssm_document.stop_instance.name
  schedule_expression = var.schedule_expressions["stop_instance"]
  compliance_severity = "MEDIUM"
  parameters = {
    AutomationAssumeRole = aws_iam_role.ssm_automation.arn
  }
  targets {
    key = "ParameterValues"
    values = [
      "aws_instance.web.id"
    ]
  }
  automation_target_parameter_name = "InstanceId"
}

data "aws_ssm_document" "stop_instance" {
  name = "AWS-StopEC2Instance"
}

data "aws_ssm_document" "start_instance" {
  name = "AWS-StartEC2Instance"
}
