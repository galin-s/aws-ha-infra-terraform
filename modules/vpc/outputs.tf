output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids" {
  value = [for s in aws_subnet.private : s.id]
}

output "s3_gateway_id" {
  value       = aws_vpc_endpoint.s3.id
  description = "ID на S3 VPC Gateway"
}
