output "monitoring_public_ip" {
  description = "The public IP of the monitoring EC2 instance"
  value       = aws_instance.monitoring.public_ip
}