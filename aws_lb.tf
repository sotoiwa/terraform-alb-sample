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

resource "aws_lb_target_group" "alb" {
  name     = "${var.app-name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    interval            = 6
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = 200
  }

  depends_on = [aws_lb.alb]
}

resource "aws_lb_target_group_attachment" "alb" {
  target_group_arn = aws_lb_target_group.alb.arn
  target_id        = aws_instance.web-instance.id
  port             = 80
}
