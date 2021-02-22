terraform {
  required_version = "~> 0.13"
}

provider "aws" {
  version = "~> 3"
  region  = var.main_region
}

# module "ec2-ssm" {
#   source = "./modules/ec2-ssm/"

#   prefix = var.resource_prefix
# }

# module "ecs-ssm" {
#   source = "./modules/ecs-ssm/"

#   prefix = var.resource_prefix
# }

module "api_gateway-lambda" {
  source = "./modules/apigw-lambda/"
}
