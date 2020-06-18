data "aws_ami" "recent_amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.????????-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "web-instance" {
  ami                    = data.aws_ami.recent_amazon_linux_2.image_id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private-subnet-a.id
  vpc_security_group_ids = [aws_security_group.web-sg.id]

  tags = {
    Name = "${var.app-name}-web-instance"
  }

  user_data = <<EOF
#!/bin/bash
yum install -y httpd
systemctl enable httpd.service
systemctl start httpd.service
hostname > /var/www/html/index.html
EOF
}
