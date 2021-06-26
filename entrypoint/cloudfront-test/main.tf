provider "aws" {
  region = var.main_region
}

module "cloudfront" {
  source = "../../modules/cloudfront/"

  prefix = var.resource_prefix
}
