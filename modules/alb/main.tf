resource "aws_lb" "alb" {
  name               = "dev-alb"
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [var.alb_sg_id]
  idle_timeout       = 60

  tags = {
    Name = "dev-alb"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "dev-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"

  health_check {
    path = "/"
    interval = 15
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
    matcher = "200-399"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
