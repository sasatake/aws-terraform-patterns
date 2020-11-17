resource "aws_security_group" "sg-ecs-nginx" {
  name   = "${var.prefix}-sg-ecs-nginx"
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.prefix}-sg-ecs-nginx"
  }
}

resource "aws_security_group_rule" "sg-in-http-ecs-nginx" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.sg-ecs-nginx.id
  cidr_blocks = [
    "0.0.0.0/0"
  ]
}

resource "aws_security_group_rule" "sg-in-https-ecs-nginx" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.sg-ecs-nginx.id
  cidr_blocks = [
    "0.0.0.0/0"
  ]
}

resource "aws_security_group_rule" "sg-out-http-ecs-nginx" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.sg-ecs-nginx.id
  cidr_blocks = [
    "0.0.0.0/0"
  ]
}

resource "aws_security_group_rule" "sg-out-https-ecs-nginx" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.sg-ecs-nginx.id
  cidr_blocks = [
    "0.0.0.0/0"
  ]
}
