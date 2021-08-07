provider "aws" {
  region = var.main_region
}

module "eks" {
  source = "../../modules/eks/"

  main_region = var.main_region
  prefix      = var.prefix
}
