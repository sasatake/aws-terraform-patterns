resource "aws_eip" "ngw" {
  tags = {
    Name            = "${var.prefix}-eip"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
  }
}
