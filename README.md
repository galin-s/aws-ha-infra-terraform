# AWS HA Infrastructure with Terraform

This repository contains a **highly-available (HA) AWS infrastructure** configuration using **Terraform**. It demonstrates a modular approach with separate modules for VPC, EC2, ALB, RDS, Security Groups and Monitoring.

## Project Structure
```
│
├── environments/
│      │
│      └── dev/        # Development environment
│
├── modules/
│      │
│      ├── alb/        # Application Load Balancer module
│      │
│      ├── ec2/        # EC2 Auto Scaling module
│      │
│      ├── monitoring/ # Prometheus & Grafana module
│      │
│      ├── rds/        # RDS module
│      │
│      ├── security/   # Security groups module
│      │
│      └── vpc/        # VPC, subnets, S3 & NAT & Internet Gateways
│
├── README.md
│
└── versions.tf   # Terraform required versions
```

## Features
- **Secure network architecture:** multi-AZ public/private subnets, NAT gateways; Internet & S3 gateways
- **Highly available compute:** multi-AZ EC2 Auto Scaling Groups deployed in private subnets
- **Managed database:** PostgreSQL on AWS RDS with multi-AZ
- **Load balancing:** Application Load Balancer distributing traffic to EC2 instances
- **Monitoring stack:** Prometheus and Grafana for metrics collection and alerting
- Modular design for easy reuse and maintainability.

## Terraform Modules

**VPC**
  - Public Subnets → ALB, NAT Gateway
  - Private Subnets → EC2 ASG, RDS
  - Internet Gateway → Public access
  - NAT Gateway → Private subnet internet access
  - S3 VPC Endpoint → Direct S3 access without going through internet

**Security** - Security Groups:
  - ALB (HTTP/HTTPS from internet)
  - EC2 (HTTP only from ALB)
  - RDS (Postgres from EC2)
  - Monitoring (Prometheus/Grafana ports)

**ALB**
  - Application Load Balancer
  - Target Group + Listener
  - Integrates with EC2 ASG

**EC2**
  - Launch template for EC2 instances
  - Docker installed with nginx + node-exporter
  - Auto Scaling Group (2 instances default)
  - ASG attached to ALB target group

**RDS**
  - PostgreSQL RDS instance
  - Multi-AZ, private subnets, backup retention
  - Secured with SG only from EC2

**Monitoring**
  - Prometheus & Grafana deployed on EC2 instances
  - Metrics collected from node-exporter on EC2
  - Alerting rules configured (e.g., high CPU usage)

## Prerequisites

- Terraform >= 1.5.x
- AWS CLI configured with appropriate credentials
- An AWS account with permissions for EC2, VPC, ELB, AutoScaling, IAM, S3
