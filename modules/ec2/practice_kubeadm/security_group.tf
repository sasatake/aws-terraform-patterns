resource "aws_security_group" "ec2" {
  name        = "${var.prefix}-sg-k8s-node"
  description = "Allow Cluster Node Connections"
  vpc_id      = var.vpc_id

  egress = [
    {
      description      = "Allow Outbound HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name            = "${var.prefix}-sg-k8s-node"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
  }
}
