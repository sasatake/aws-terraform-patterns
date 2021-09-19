provider "aws" {
  region = var.default_region
}

module "vpc" {
  source = "../../modules/vpc/public_only/"
  prefix = var.prefix
}

module "ec2" {
  source         = "../../modules/ec2/practice_kubeadm/"
  prefix         = var.prefix
  instance_type  = "t3.small"
  vpc_id         = module.vpc.vpc_id
  vpc_cidr_block = module.vpc.vpc_cidr_block
  subnet_id      = module.vpc.subnet_id_list[0]
  subnet_az_name = module.vpc.subnet_az_list[0]

  depends_on = [
    module.vpc
  ]
}

resource "local_file" "master_private_key" {
  filename        = "${path.module}/master.id_rsa.pem"
  content         = module.ec2.master_private_key
  file_permission = "0600"
}

resource "local_file" "master_ssh_alias" {
  filename = "${path.module}/ssh_alias.master.sh"
  content = templatefile("${path.module}/templates/ssh_alias.sh.tpl", {
    secret = local_file.master_private_key.filename
    host   = module.ec2.master_id
  })
  file_permission = "0555"
}

resource "local_file" "worker_private_key" {
  filename        = "${path.module}/worker.id_rsa.pem"
  content         = module.ec2.worker_private_key
  file_permission = "0600"
}

resource "local_file" "worker_ssh_alias" {
  filename = "${path.module}/ssh_alias.worker.sh"
  content = templatefile("${path.module}/templates/ssh_alias.sh.tpl", {
    secret = local_file.worker_private_key.filename
    host   = module.ec2.worker_id
  })
  file_permission = "0555"
}
