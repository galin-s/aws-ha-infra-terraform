output "alb_sg_id" {
  description = "ALB Security Group ID"
  value       = aws_security_group.alb_sg.id
}

output "ec2_sg_id" {
  description = "EC2 Security Group ID"
  value       = aws_security_group.ec2_sg.id
}

output "ec2_sg_name" {
  description = "EC2 Security Group Name"
  value       = aws_security_group.ec2_sg.name
}

output "rds_sg_id" {
  description = "RDS Security Group ID"
  value = aws_security_group.rds_sg.id
}
