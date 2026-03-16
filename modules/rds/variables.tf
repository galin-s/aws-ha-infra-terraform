variable "environment" {
  description = "Environment name"
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "db_sg_id" {
  description = "Database Security Group ID"
  type = string
}

variable "db_username" {
  description = "Database Credentials Username"
  type = string
}

variable "db_password" {
  description = "Database Credentials Password"
  type = string
}
