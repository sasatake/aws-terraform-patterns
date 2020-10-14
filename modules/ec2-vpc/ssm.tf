resource "aws_ssm_association" "stop_instance" {
  name                = data.aws_ssm_document.stop_instance
  instance_id         = aws_instance.web.id
  schedule_expression = "5 * *	*	*	*"
}

data "aws_ssm_document" "stop_instance" {
  name = "AWS-StopEC2Instance"
}

data "aws_ssm_document" "start_instance" {
  name = "AWS-StartEC2Instance"
}
