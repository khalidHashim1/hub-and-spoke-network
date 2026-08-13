resource "aws_ec2_transit_gateway" "main" {
  description = var.description
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  dns_support = "enable"

  tags = {
    Name = var.name
    ManagedBy = "Terraform"
  }
}

resource "aws_ec2_transit_gateway_route_table" "main" {
  transit_gateway_id = aws_ec2_transit_gateway.main.id

  tags = {
    Name      = "${var.name}-route-table"
    ManagedBy = "Terraform"
  }
}
