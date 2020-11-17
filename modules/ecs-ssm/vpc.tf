resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name            = "${var.prefix}-vpc"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
    ProvisionedFor  = "ecs"
  }
}

resource "aws_subnet" "public-subnet-01" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name            = "${var.prefix}-public_subnet_01"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
    ProvisionedFor  = "ecs"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name            = "${var.prefix}-igw"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
    ProvisionedFor  = "ecs"
  }
}

resource "aws_route_table" "rtb-public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name            = "${var.prefix}-rtb-public"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
    ProvisionedFor  = "ecs"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-subnet-01.id
  route_table_id = aws_route_table.rtb-public.id
}
