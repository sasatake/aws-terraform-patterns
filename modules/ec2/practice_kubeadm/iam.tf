resource "aws_iam_role" "ec2" {
  name               = "${replace(title(var.prefix), "-", "")}EC2K8sNodeRole"
  assume_role_policy = file("${path.module}/templates/iam/EC2AssumeRolePolicy.json")
}

data "aws_iam_policy" "ec2" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ec2" {
  role       = aws_iam_role.ec2.id
  policy_arn = data.aws_iam_policy.ec2.arn
}


resource "aws_iam_instance_profile" "ec2" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2.name
}
