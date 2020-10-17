terraform {
  required_version = "~> 0.13"
}

provider "aws" {
  version = "~> 3"
  region  = var.main_region
}

module "ec2-ssm" {
  source = "./modules/ec2-ssm/"

  prefix = var.resource_prefix
}
