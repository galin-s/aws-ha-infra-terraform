output "alb_arn" {
  description = "Application Load Balancer ARN"
  value       = aws_lb.alb.arn
}

output "alb_dns_name" {
  description = "DNS name for ALB"
  value       = aws_lb.alb.dns_name
}

output "target_group_arn" {
  description = "Target Group ARN"
  value       = aws_lb_target_group.tg.arn
}
output "target_group_id" {
  description = "Target group ID"
  value       = aws_lb_target_group.tg.id
}
