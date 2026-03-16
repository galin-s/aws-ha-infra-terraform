output "db_endpoint" {
  description = "Database Endpoint"
  value = aws_db_instance.this.endpoint
}

output "db_identifier" {
  description = "Database Instance ID"
  value = aws_db_instance.this.id
}
