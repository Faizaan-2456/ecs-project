# Create ALB
resource "aws_lb" "ecs_project_alb" {
  name               = "ecs_project_alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = aws_subnet.public-subnet-1.id

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}


# Create target group
resource "aws_lb_target_group" "ecs_target_group" {
  name        = "ecs-target-group"
  port        = 443
  protocol    = "HTTPS"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    protocol = "HTTP"
    path = "/health"

  }
}


# Add listener
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.ecs_project_alb.arn
  port              = "443"
  protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
  }
}


# Create security group
resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  description = "Allow inbound traffic from port 80 and 443"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_port_80_http" {
  security_group_id = aws_security_group.allow_port_80_http.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_port_443_https" {
  security_group_id = aws_security_group.allow_port_443_https.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}