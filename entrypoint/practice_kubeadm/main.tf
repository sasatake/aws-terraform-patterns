provider "aws" {
  region = var.default_region
}

module "vpc" {
  source = "../../modules/vpc/public_only/"
  prefix = var.prefix
}
