# AWS Hub-and-Spoke Network Architecture with Terraform

## Overview

This project demonstrates a **production-style AWS Hub-and-Spoke network architecture** built entirely with **Terraform**.

The objective is to simulate how enterprise organizations centralize networking using **AWS Transit Gateway**, allowing multiple VPCs to communicate securely while maintaining a scalable and modular Infrastructure as Code (IaC) design.

This project focuses on AWS networking concepts, Terraform module design, high availability, and enterprise infrastructure best practices.

---

## Architecture

The current architecture consists of a single AWS Region (**us-east-1**) with one centralized Transit Gateway acting as the network hub.

### Hub

- AWS Transit Gateway
- Transit Gateway Route Table

### Spoke VPCs

- Production VPC
- Development VPC
- Shared Services VPC

Each VPC includes:

- Multi-AZ deployment
- 2 Public Subnets
- 2 Private Subnets
- Internet Gateway
- NAT Gateway per Availability Zone
- Public Route Table
- Private Route Tables
- EC2 instance in a Private Subnet

Every VPC is attached to the Transit Gateway through a dedicated **Transit Gateway VPC Attachment**.

Private routing enables communication between all spoke VPCs through the centralized hub.

---

## Architecture Diagram

> Replace this image with your exported AWS architecture diagram.

![Architecture](tgw.png)

---

## Technologies Used

- AWS VPC
- AWS Transit Gateway
- AWS EC2
- AWS IAM
- AWS Security Groups
- AWS Internet Gateway
- AWS NAT Gateway
- AWS Route Tables
- Terraform
- Infrastructure as Code (IaC)

---

## Project Structure

```text
terraform
│
├── environments
│   └── dev
│       ├── main.tf
│       ├── providers.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── tgw.tf
│
└── modules
    ├── VPC
    ├── Transit-Gateway
    └── EC2
```

---

## Network Topology

```text
                    AWS Cloud
                       │
                us-east-1 Region
                       │
               ┌────────────────┐
               │ Transit Gateway│
               └────────────────┘
                 /      |       \
                /       |        \
               /        |         \
          Prod VPC   Dev VPC   Shared VPC
```

---

## Features

- Modular Terraform design
- Reusable infrastructure modules
- Enterprise Hub-and-Spoke architecture
- Multi-AZ deployment
- High Availability
- Centralized networking
- Transit Gateway routing
- Private inter-VPC communication
- Security Groups for controlled traffic
- Infrastructure fully managed as code

---

## Networking Flow

Example communication between Production and Development VPC:

```text
EC2 (Production)
        │
Private Route Table
        │
Transit Gateway Attachment
        │
Transit Gateway
        │
Transit Gateway Route Table
        │
Transit Gateway Attachment
        │
Private Route Table
        │
EC2 (Development)
```

---

## What I Learned

This project helped me gain practical experience with:

- Enterprise AWS network design
- Hub-and-Spoke architecture
- Transit Gateway
- VPC Attachments
- Route Tables
- Route Propagation
- High Availability design
- Infrastructure as Code
- Terraform module architecture
- AWS networking best practices

---

## Future Improvements

Planned enhancements include:

- Multi-Region Hub-and-Spoke
- Transit Gateway Inter-Region Peering
- Inspection VPC
- AWS Network Firewall
- Route 53
- VPC Endpoints
- AWS Organizations
- Landing Zone Architecture
- CI/CD pipeline with GitHub Actions
- Remote Terraform State (S3 + DynamoDB)

---

## Author

**Khalid Hashim**

AWS Certified Solutions Architect – Associate

- LinkedIn: https://www.linkedin.com/in/khalid-hashim-8639a7271
- Portfolio: https://khalidhashim.com

---

## License

This project is available for learning and demonstration purposes.
