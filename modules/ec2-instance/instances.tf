# Create App Server Instance
resource "aws_instance" "app" {
  for_each               = var.appserver_configs
  ami                    = data.aws_ami.latest_rhel.id
  instance_type          = local.instance_type
  key_name               = data.aws_key_pair.ssh.key_name
  subnet_id              = aws_subnet.private[each.key].id
  vpc_security_group_ids = ["${aws_security_group.web.id}"]
  user_data              = file("/workspace/AWS_Terraform/modules/ec2-instance/website.sh")

  tags = {
    Name = each.value
  }
}

# Create Application Load Balancer
resource "aws_lb" "app" {
  name               = "Dev-ALB"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]
}

# Application Load Balancer Target Group
resource "aws_lb_target_group" "app" {
  name     = "Appserver-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

# ALB Target Group Attachment
resource "aws_lb_target_group_attachment" "app" {
  # covert a list of instance objects to a map with instance ID as the key, and an instance
  # object as the value.
  for_each = var.appserver_configs

  target_group_arn = aws_lb_target_group.app.arn
  target_id        = aws_instance.app[each.key].id
  port             = 80

  depends_on = [ aws_instance.app ]
}

# ALB HTTP Listener
resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}