variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "ec2_sg_id" {
  description = "The ID of the EC2 Security Group"
  type        = string
}

variable "ec2_sg_name" {
  description = "Name of the EC2 security group"
  type        = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "min_size" {
  type    = number
  default = 2
}

variable "max_size" {
  type    = number
  default = 2
}

variable "desired_capacity" {
  type    = number
  default = 2
}

 variable "target_group_arn" {
  description = "ARN of the ALB target group to attach the ASG"
  type        = string
}
