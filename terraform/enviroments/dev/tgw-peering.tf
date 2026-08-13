resource "aws_ec2_transit_gateway_vpc_attachment" "prod" {
  provider = aws.us_east_1

  transit_gateway_id = module.tgw_hub.transit_gateway_id
  vpc_id             = module.vpc_prod.vpc_id

  subnet_ids = module.vpc_prod.private_subnet_ids

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name      = "tgw-attachment-prod"
    ManagedBy = "Terraform"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "dev" {
  provider = aws.us_east_1

  transit_gateway_id = module.tgw_hub.transit_gateway_id
  vpc_id             = module.vpc_dev.vpc_id

  subnet_ids = module.vpc_dev.private_subnet_ids

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name      = "tgw-attachment-dev"
    ManagedBy = "Terraform"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "shared_services" {
  provider = aws.us_east_1

  transit_gateway_id = module.tgw_hub.transit_gateway_id
  vpc_id             = module.vpc_shared_services.vpc_id

  subnet_ids = module.vpc_shared_services.private_subnet_ids

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name      = "tgw-attachment-shared-services"
    ManagedBy = "Terraform"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "prod" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.prod.id
  transit_gateway_route_table_id = module.tgw_hub.transit_gateway_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_association" "dev" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.dev.id
  transit_gateway_route_table_id = module.tgw_hub.transit_gateway_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_association" "shared_services" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.shared_services.id
  transit_gateway_route_table_id = module.tgw_hub.transit_gateway_route_table_id
}

#propagation
resource "aws_ec2_transit_gateway_route_table_propagation" "prod" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.prod.id
  transit_gateway_route_table_id = module.tgw_hub.transit_gateway_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "dev" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.dev.id
  transit_gateway_route_table_id = module.tgw_hub.transit_gateway_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "shared_services" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.shared_services.id
  transit_gateway_route_table_id = module.tgw_hub.transit_gateway_route_table_id
}