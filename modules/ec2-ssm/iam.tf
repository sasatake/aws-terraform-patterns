resource "aws_iam_role" "ec2_web" {
  name               = "${replace(title(var.prefix), "-", "")}EC2WebAttachRole"
  assume_role_policy = file("${path.module}/templates/iam/EC2AssumeRolePolicy.json")
}

resource "aws_iam_role_policy_attachment" "ec2_web" {
  role       = aws_iam_role.ec2_web.id
  policy_arn = data.aws_iam_policy.ec2_web.arn
}

data "aws_iam_policy" "ec2_web" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_instance_profile" "ec2_web" {
  name = "ec2_web_instance_profile"
  role = aws_iam_role.ec2_web.name
}

resource "aws_iam_role" "ssm_automation" {
  name               = "${replace(title(var.prefix), "-", "")}SSMAutomationRole"
  assume_role_policy = file("${path.module}/templates/iam/SSMAutomationAssumeRolePolicy.json")
}

resource "aws_iam_role_policy_attachment" "ssm_automation" {
  role       = aws_iam_role.ssm_automation.id
  policy_arn = data.aws_iam_policy.ssm_automation.arn
}

data "aws_iam_policy" "ssm_automation" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMAutomationRole"
}
