resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name            = "${var.prefix}-vpc"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
    ProvisionedFor  = "eks"
  }
}

resource "aws_subnet" "public_subnet_01" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name            = "${var.prefix}-public_subnet_01"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
    ProvisionedFor  = "eks"
  }
}

resource "aws_subnet" "private_subnet_01" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name            = "${var.prefix}-private_subnet_01"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
    ProvisionedFor  = "eks"
  }
}

resource "aws_subnet" "private_subnet_02" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name            = "${var.prefix}-private_subnet_02"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
    ProvisionedFor  = "eks"
  }
}
