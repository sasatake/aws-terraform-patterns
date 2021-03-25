resource "aws_iam_role" "ssm_automation" {
  name               = "${replace(title(var.prefix), "-", "")}SSMAutomationRole"
  assume_role_policy = file("${path.module}/templates/iam/SSMAutomationAssumeRolePolicy.json")
}

resource "aws_iam_role_policy_attachment" "ssm_automation" {
  role       = aws_iam_role.ssm_automation.id
  policy_arn = aws_iam_policy.ssm_automation.id
}

resource "aws_iam_policy" "ssm_automation" {
  name   = "${replace(title(var.prefix), "-", "")}SSMAutomationECSPolicy"
  policy = file("${path.module}/templates/iam/SSMAutomationECSPolicy.json")
}
