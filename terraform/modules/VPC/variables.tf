variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_a_cidr_block" {
  description = "CIDR block for public subnet A"
  type        = string
}

variable "public_a_availability_zone" {
  description = "Availability Zone for public subnet A"
  type        = string
}

variable "private_a_cidr_block" {
  description = "CIDR block for private subnet A"
  type        = string
}

variable "private_a_availability_zone" {
  description = "Availability Zone for private subnet A"
  type        = string
}

variable "public_b_cidr_block" {
  description = "CIDR block for public subnet B"
  type = string
}

variable "public_b_availability_zone" {
  description = "Availability Zone for public subnet B"
  type = string
}

variable "private_b_cidr_block" {
  description = "CIDR block for private subnet B"
  type = string
}

variable "private_b_availability_zone" {
  description = "Availability Zone for private subnet B"
  type = string
}

variable "transit_gateway_id" {
  description = "Transit Gateway ID used for remote VPC routing"
  type        = string
}


variable "allowed_vpc_cidrs" {
  description = "Remote VPC CIDRs reachable through the Transit Gateway"
  type        = list(string)
  default     = []
}