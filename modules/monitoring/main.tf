resource "aws_instance" "monitoring" {
  ami           = var.ami_id
  instance_type = "t3.micro"

  subnet_id = var.subnet_id
  vpc_security_group_ids = [
    aws_security_group.monitoring_sg.id
  ]

  iam_instance_profile = aws_iam_instance_profile.prometheus_profile.name

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "monitoring-instance"
  }
}
