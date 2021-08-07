resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name            = "${var.prefix}-rtb_public"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
    ProvisionedFor  = "eks"
  }
}

resource "aws_route_table" "rtb_private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name            = "${var.prefix}-rtb_private"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
    ProvisionedFor  = "eks"
  }
}


resource "aws_route_table_association" "public_subnet_01" {
  subnet_id      = aws_subnet.public_subnet_01.id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_route_table_association" "private_subnet_01" {
  subnet_id      = aws_subnet.private_subnet_01.id
  route_table_id = aws_route_table.rtb_private.id
}

resource "aws_route_table_association" "private_subnet_02" {
  subnet_id      = aws_subnet.private_subnet_02.id
  route_table_id = aws_route_table.rtb_private.id
}
