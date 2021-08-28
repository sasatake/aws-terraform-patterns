output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "subnet_id_list" {
  value = aws_subnet.public[*].id
}

output "subnet_az_list" {
  value = aws_subnet.public[*].availability_zone
}
