output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "public_subnet_a_id" {
  description = "ID of public subnet A"
  value       = aws_subnet.public-a.id
}

output "public_subnet_b_id" {
  description = "ID of public subnet B"
  value       = aws_subnet.public-b.id
}

output "private_subnet_a_id" {
  description = "ID of private subnet A"
  value       = aws_subnet.private-a.id
}

output "private_subnet_b_id" {
  description = "ID of private subnet B"
  value       = aws_subnet.private-b.id
}

output "public_subnet_ids" {
  description = "IDs of all public subnets"
  value = [
    aws_subnet.public-a.id,
    aws_subnet.public-b.id
  ]
}

output "private_subnet_ids" {
  description = "IDs of all private subnets"
  value = [
    aws_subnet.private-a.id,
    aws_subnet.private-b.id
  ]
}

output "nat_gateway_a_id" {
  description = "ID of NAT Gateway A"
  value       = aws_nat_gateway.nat-a.id
}

output "nat_gateway_b_id" {
  description = "ID of NAT Gateway B"
  value       = aws_nat_gateway.nat-b.id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public-route-table.id
}

output "private_route_table_a_id" {
  description = "ID of private route table A"
  value       = aws_route_table.private-a-route-table.id
}

output "private_route_table_b_id" {
  description = "ID of private route table B"
  value       = aws_route_table.private-b-route-table.id
}

output "private_route_table_ids" {
  description = "IDs of the private route tables"

  value = [
    aws_route_table.private-a-route-table.id,
    aws_route_table.private-b-route-table.id
  ]
}
