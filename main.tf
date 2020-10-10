terraform {
  required_version = "~> 0.13"
}

provider "aws" {
  version = "~> 3"
  region  = var.main_region
}

module "ec2-vpc" {
  source = "./modules/ec2-vpc/"

  prefix = var.resource_prefix
}
