resource "aws_nat_gateway" "eks" {
  allocation_id = aws_eip.ngw.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name            = "${var.prefix}-ngw"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
  }

  depends_on = [aws_internet_gateway.igw]
}
