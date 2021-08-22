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
  }
}

resource "aws_route_table_association" "public_subnet" {
  count = length(aws_subnet.public[*])

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_route_table" "rtb_private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks.id
  }

  tags = {
    Name            = "${var.prefix}-rtb_private"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
  }
}

resource "aws_route_table_association" "private_subnet" {
  count = length(aws_subnet.private[*])

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.rtb_private.id
}
