resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name            = "${var.prefix}-vpc"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
  }
}

resource "aws_subnet" "public" {
  count = length(var.subnet_az_list)

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = var.subnet_az_list[count.index]

  tags = {
    Name            = "${var.prefix}-public_subnet_0${count.index + 1}"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
  }
}
