resource "aws_security_group" "web-sg" {
  name   = "${var.app-name}-web-sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "web-sg" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb-sg.id
  security_group_id        = aws_security_group.web-sg.id
}

resource "aws_security_group_rule" "web-sg-1" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web-sg.id
}

resource "aws_security_group_rule" "web-sg-2" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web-sg.id
}

resource "aws_security_group" "alb-sg" {
  name   = "${var.app-name}-alb-sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "alb-sg" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb-sg.id
}

resource "aws_security_group_rule" "alb-sg-2" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb-sg.id
}
