data "aws_ssm_parameter" "this" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "web" {
  ami                    = data.aws_ssm_parameter.this.value
  instance_type          = "t3.small"
  subnet_id              = aws_subnet.private_a.id
  vpc_security_group_ids = [aws_security_group.web.id]
  iam_instance_profile   = aws_iam_instance_profile.this.id

  tags = {
    Name = "${var.app_name}-web-instance"
  }

  user_data = <<EOF
#!/bin/bash
yum install -y httpd
systemctl enable httpd.service
systemctl start httpd.service
hostname > /var/www/html/index.html
EOF

}
