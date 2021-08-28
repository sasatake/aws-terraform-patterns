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
  subnet_id      = module.vpc.subnet_id_list[0]
  subnet_az_name = module.vpc.subnet_az_list[0]

  depends_on = [
    module.vpc
  ]
}
