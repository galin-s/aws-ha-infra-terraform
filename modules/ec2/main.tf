# Launch Template
resource "aws_launch_template" "web" {
  name_prefix   = "dev-web-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [var.ec2_sg_id]
  

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "dev-web-instance"
    }
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install docker -y
    service docker start
    docker run -d -p 80:80 nginx
    docker run -d \
      --name node-exporter \
      -p 9100:9100 \
      prom/node-exporter

    EOF
  )
}

# Auto Scaling Group
resource "aws_autoscaling_group" "web_asg" {
  name             = "dev-web-asg"
  max_size         = var.max_size
  min_size         = var.min_size
  desired_capacity = var.desired_capacity

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  vpc_zone_identifier = var.private_subnet_ids
  health_check_type   = "EC2"
  force_delete        = true

  tag {
    key                 = "Name"
    value               = "dev-web-asg-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "monitor"
    value               = "true"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "asg_to_tg" {
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
  lb_target_group_arn    = var.target_group_arn
}
