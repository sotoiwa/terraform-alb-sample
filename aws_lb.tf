resource "aws_lb" "alb" {
  name                       = "${var.app-name}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb-sg.id]
  enable_deletion_protection = false
  idle_timeout               = 30
  subnets = [
    aws_subnet.public-subnet-a.id,
    aws_subnet.public-subnet-c.id
  ]

  tags = {
    "Name" = "${var.app-name}-alb"
  }
}

resource "aws_lb_listener" "alb" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb.arn
  }

  depends_on    = [aws_lb_target_group.alb]
}
