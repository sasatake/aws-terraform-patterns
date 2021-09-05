resource "tls_private_key" "master" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_private_key" "worker" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "master" {
  public_key = tls_private_key.master.public_key_openssh
}

resource "aws_key_pair" "worker" {
  public_key = tls_private_key.worker.public_key_openssh
}


resource "aws_spot_instance_request" "master" {
  ami                         = data.aws_ami.amazonlinux2.id
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.ec2.id
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  wait_for_fulfillment        = true
  associate_public_ip_address = true
  key_name                    = aws_key_pair.master.id
  user_data = templatefile("${path.module}/templates/ec2/cloud-config.yml.tpl", {
    hostname = "k8s-master"
  })

  root_block_device {
    volume_size = 8
    tags = {
      Name = "${var.prefix}-ebs-k8s-master"
    }
  }

  tags = {
    Name            = "${var.prefix}-ec2spot-k8s-master"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
  }
}

resource "aws_ec2_tag" "master" {
  resource_id = aws_spot_instance_request.master.spot_instance_id
  key         = "Name"
  value       = "${var.prefix}-ec2-k8s-master"
}

resource "aws_spot_instance_request" "worker" {
  ami                         = data.aws_ami.amazonlinux2.id
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.ec2.id
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  wait_for_fulfillment        = true
  associate_public_ip_address = true
  key_name                    = aws_key_pair.worker.id

  root_block_device {
    volume_size = 8
    tags = {
      Name = "${var.prefix}-ebs-k8s-worker"
    }
  }

  tags = {
    Name            = "${var.prefix}-ec2spot-k8s-worker"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
  }
}

resource "aws_ec2_tag" "worker" {
  resource_id = aws_spot_instance_request.worker.spot_instance_id
  key         = "Name"
  value       = "${var.prefix}-ec2-k8s-worker"
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
