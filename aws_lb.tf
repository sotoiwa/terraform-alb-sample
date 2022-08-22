resource "aws_lb" "this" {
  name                       = "${var.app-name}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb.id]
  enable_deletion_protection = false
  idle_timeout               = 30
  subnets = [
    aws_subnet.public_a.id,
    aws_subnet.public_c.id
  ]

  tags = {
    "Name" = "${var.app-name}-alb"
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
