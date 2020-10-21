resource "aws_instance" "web" {
  ami           = data.aws_ami.amazonlinux2.id
  instance_type = var.instance_type

  tags = {
    Name            = "${var.prefix}-ec2-web"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
  }
}

data "aws_ami" "amazonlinux2" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*.0-x86_64-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}
