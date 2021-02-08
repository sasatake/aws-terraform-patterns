resource "aws_iam_role" "events_call_ssmdoc" {
  name               = "${replace(title(var.prefix), "-", "")}EventsCallSSMDocRole"
  assume_role_policy = file("${path.module}/templates/iam/EventsCallSSMDocAssumeRolePolicy.json")
}

resource "aws_iam_role_policy_attachment" "events_call_ssmdoc" {
  role       = aws_iam_role.cloudwatch_event_ssm_automation.id
  policy_arn = aws_iam_policy.events_call_ssmdoc.id
}

resource "aws_iam_policy" "events_call_ssmdoc" {
  name   = "${replace(title(var.prefix), "-", "")}EventsCallSSMDocPolicy"
  policy = file("${path.module}/templates/iam/EventsCallSSMDocPolicy.json")
}
