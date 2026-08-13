module "vpc_prod" {
  source = "../../modules/VPC"

  providers = {
    aws = aws.us_east_1
  }

  vpc_cidr_block = "10.0.0.0/16"

  public_a_cidr_block = "10.0.1.0/24"
  public_b_cidr_block = "10.0.2.0/24"

  private_a_cidr_block = "10.0.11.0/24"
  private_b_cidr_block = "10.0.22.0/24"

  public_a_availability_zone = "us-east-1a"
  public_b_availability_zone = "us-east-1b"

  private_a_availability_zone = "us-east-1a"
  private_b_availability_zone = "us-east-1b"

  transit_gateway_id = module.tgw_hub.transit_gateway_id

  allowed_vpc_cidrs = [
    "10.1.0.0/16",
    "10.2.0.0/16"
  ]
}

module "vpc_dev" {
  source = "../../modules/VPC"

  providers = {
    aws = aws.us_east_1
  }

  vpc_cidr_block = "10.1.0.0/16"

  public_a_cidr_block = "10.1.1.0/24"
  public_b_cidr_block = "10.1.2.0/24"

  private_a_cidr_block = "10.1.11.0/24"
  private_b_cidr_block = "10.1.22.0/24"

  public_a_availability_zone = "us-east-1a"
  public_b_availability_zone = "us-east-1b"

  private_a_availability_zone = "us-east-1a"
  private_b_availability_zone = "us-east-1b"

  transit_gateway_id = module.tgw_hub.transit_gateway_id

  allowed_vpc_cidrs = [
    "10.0.0.0/16",
    "10.2.0.0/16"
  ]
}

module "vpc_shared_services" {
  source = "../../modules/VPC"

  providers = {
    aws = aws.us_east_1
  }

  vpc_cidr_block = "10.2.0.0/16"

  public_a_cidr_block = "10.2.1.0/24"
  public_b_cidr_block = "10.2.2.0/24"

  private_a_cidr_block = "10.2.11.0/24"
  private_b_cidr_block = "10.2.22.0/24"

  public_a_availability_zone = "us-east-1a"
  public_b_availability_zone = "us-east-1b"

  private_a_availability_zone = "us-east-1a"
  private_b_availability_zone = "us-east-1b"

  transit_gateway_id = module.tgw_hub.transit_gateway_id

  allowed_vpc_cidrs = [
    "10.0.0.0/16",
    "10.1.0.0/16"
  ]
}


module "tgw_hub" {
  source = "../../modules/Transit-Gateway"

  providers = {
    aws = aws.us_east_1
  }

  name        = "tgw-hub-us-east-1"
  description = "Hub Transit Gateway for Prod Dev and Shared Services"
}


module "ec2_prod" {
  source = "../../modules/ec2"

  providers = {
    aws = aws.us_east_1
  }

  ami_id        = "ami-0bdc7d025135d7b49"
  instance_type = "t3.micro"
  subnet_id     = module.vpc_prod.private_subnet_a_id
  vpc_id        = module.vpc_prod.vpc_id
  allowed_vpc_cidrs = [
    "10.1.0.0/16",
    "10.2.0.0/16"
  ]

  instance_name = "ec2-prod-private"
}

module "ec2_dev" {
  source = "../../modules/ec2"

  providers = {
    aws = aws.us_east_1
  }

  ami_id        = "ami-0bdc7d025135d7b49"
  instance_type = "t3.micro"
  subnet_id     = module.vpc_dev.private_subnet_a_id
  vpc_id        = module.vpc_dev.vpc_id
  allowed_vpc_cidrs = [
    "10.0.0.0/16",
    "10.2.0.0/16"
  ]

  instance_name = "ec2-dev-private"
}

module "ec2_shared_services" {
  source = "../../modules/ec2"

  providers = {
    aws = aws.us_east_1
  }

  ami_id        = "ami-0bdc7d025135d7b49"
  instance_type = "t3.micro"
  subnet_id     = module.vpc_shared_services.private_subnet_a_id
  vpc_id        = module.vpc_shared_services.vpc_id
  allowed_vpc_cidrs = [
    "10.0.0.0/16",
    "10.1.0.0/16"
  ]

  instance_name = "ec2-shared-services-private"
} 
