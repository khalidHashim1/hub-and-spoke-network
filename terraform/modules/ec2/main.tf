resource "aws_instance" "main" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  associate_public_ip_address = false

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  tags = {
    Name      = var.instance_name
    ManagedBy = "Terraform"
  }
}


# IAM Role for EC2
resource "aws_iam_role" "ec2_role" {
  name = "${var.instance_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    ManagedBy = "Terraform"
  }
}

# Allow EC2 to communicate with AWS Systems Manager
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.instance_name}-profile"
  role = aws_iam_role.ec2_role.name
}


resource "aws_security_group" "ec2_sg" {
  name        = "${var.instance_name}-sg"
  description = "Security group for private TGW test instance"
  vpc_id      = var.vpc_id

  tags = {
    Name      = "${var.instance_name}-sg"
    ManagedBy = "Terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "icmp_remote_vpc" {
  security_group_id = aws_security_group.ec2_sg.id

  ip_protocol = "icmp"
  from_port   = -1
  to_port     = -1
  
  for_each = toset(var.allowed_vpc_cidrs)
  cidr_ipv4 = each.value

  description = "Allow ICMP from remote VPC through TGW"
}

resource "aws_vpc_security_group_egress_rule" "all_outbound" {
  security_group_id = aws_security_group.ec2_sg.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"

  description = "Allow all outbound traffic"
}
