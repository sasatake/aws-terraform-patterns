terraform {
  required_version = "~> 0.13"
}

provider "aws" {
  version = "~> 3"
  region  = var.main_region
}
