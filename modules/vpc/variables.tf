variable "vpc_cidr" {
  description = "VPC CIDR"
  type = string
}

variable "environment" {
  description = "Environment name"
  type = string
}

variable "region" {
  description = "AWS region for resources"
  type        = string
  default     = "eu-central-1"
}
