
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "main-vpc"
    ManagedBy = "Terraform"
  }
}

# Subnets
resource "aws_subnet" "public-a" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_a_cidr_block
  availability_zone = var.public_a_availability_zone
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private-a" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_a_cidr_block
  availability_zone = var.private_a_availability_zone
}

resource "aws_subnet" "public-b" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_b_cidr_block
  availability_zone = var.public_b_availability_zone
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private-b" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_b_cidr_block
  availability_zone = var.private_b_availability_zone
}

#igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}

# Public Routing table 
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.main.id

  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public-a-association" {
  subnet_id = aws_subnet.public-a.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-b-association" {
  subnet_id = aws_subnet.public-b.id
  route_table_id = aws_route_table.public-route-table.id
}

# Private Routing

resource "aws_eip" "nat-a" {
  domain = "vpc"

  tags = {
    Name = "nat-eip-a"
  }
}

resource "aws_eip" "nat-b" {
  domain = "vpc"

  tags = {
    Name = "nat-eip-b"
  }
}

# Nat

resource "aws_nat_gateway" "nat-a" {
  allocation_id = aws_eip.nat-a.id
  subnet_id = aws_subnet.public-a.id

  depends_on = [ aws_internet_gateway.igw ]

  tags = {
    Name = "nat-gateway-a"
  }
}

resource "aws_nat_gateway" "nat-b" {
  allocation_id = aws_eip.nat-b.id
  subnet_id = aws_subnet.public-b.id

  depends_on = [ aws_internet_gateway.igw ]

  tags = {
    Name = "nat-gateway-b"
  }
}

resource "aws_route_table" "private-a-route-table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-a.id
  }
}

resource "aws_route_table" "private-b-route-table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-b.id
  }
}

resource "aws_route_table_association" "private-a-association" {
  subnet_id = aws_subnet.private-a.id
  route_table_id = aws_route_table.private-a-route-table.id
}

resource "aws_route_table_association" "private-b-association" {
  subnet_id = aws_subnet.private-b.id
  route_table_id = aws_route_table.private-b-route-table.id
}

resource "aws_route" "private_a_to_tgw" {
  for_each = toset(var.allowed_vpc_cidrs)

  route_table_id         = aws_route_table.private-a-route-table.id
  destination_cidr_block = each.value
  transit_gateway_id     = var.transit_gateway_id
}

resource "aws_route" "private_b_to_tgw" {
  for_each = toset(var.allowed_vpc_cidrs)

  route_table_id         = aws_route_table.private-b-route-table.id
  destination_cidr_block = each.value
  transit_gateway_id     = var.transit_gateway_id
}