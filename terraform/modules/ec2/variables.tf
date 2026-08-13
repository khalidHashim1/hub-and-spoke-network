variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet where the EC2 instance will be created"
  type        = string
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the EC2 security group will be created"
  type        = string
}

variable "allowed_vpc_cidrs" {
  description = "CIDRs allowed to communicate with this EC2 instance"
  type        = list(string)
  default     = []
}