provider "aws" {
  region = var.main_region
}

module "vpc" {
  source = "../../modules/vpc-eks/"

  prefix = var.prefix
}

module "eks" {
  source = "../../modules/eks/"

  prefix                 = var.prefix
  vpc_id                 = module.vpc.vpc_id
  vpc_cidr_block         = module.vpc.vpc_cidr_block
  subnet_id_list         = module.vpc.subnet_id_list
  private_subnet_id_list = module.vpc.private_subnet_id_list
}
