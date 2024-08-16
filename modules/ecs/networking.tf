resource "aws_security_group" "alb_sg" {
  name        = local.alb_sg_name
  description = local.alb_sg_description
  vpc_id      = var.vpc_id
  tags = {
    Name        = local.alb_sg_name
    Environment = var.environment
  }
  ingress {
    protocol    = local.protocol_tcp
    from_port   = local.http_port
    to_port     = local.http_port
    cidr_blocks = [local.cidr_all_ipv4]
  }

  egress {
    protocol    = local.protocol_all
    from_port   = local.all_port
    to_port     = local.all_port
    cidr_blocks = [local.cidr_all_ipv4]
  }
}

resource "aws_security_group" "ecs_tasks_sg" {
  name        = local.ecs_tasks_sg_name
  description = local.ecs_tasks_sg_description
  vpc_id      = var.vpc_id
  tags = {
    Name        = local.ecs_tasks_sg_name
    Environment = var.environment
  }
  ingress {
    protocol        = local.protocol_all
    from_port       = local.all_port
    to_port         = local.all_port
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    from_port = local.all_port
    to_port   = local.all_port
    protocol  = local.protocol_all
    self      = true
  }
  ingress {
    from_port   = local.mongodb_port
    to_port     = local.mongodb_port
    protocol    = local.protocol_tcp
    cidr_blocks = [local.cidr_all_ipv4]
  }
  egress {
    protocol    = local.protocol_all
    from_port   = local.all_port
    to_port     = local.all_port
    cidr_blocks = [local.cidr_all_ipv4]
  }
}
data "aws_acm_certificate" "ssl_cert" {
  domain   = "*.xquic.com"
  statuses = ["ISSUED"]
}

resource "aws_lb" "alb" {
  name                       = local.alb_name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_sg.id]
  subnets                    = var.public_subnet_ids
  enable_deletion_protection = true
  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "nodejs_backend" {
  name        = "${local.target_group_name}-nodejs"
  port        = var.nodejs_backend_port
  protocol    = local.protocol_http
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    healthy_threshold   = local.health_check_healthy_threshold
    interval            = local.health_check_interval
    protocol            = local.health_check_protocol
    port                = local.health_check_port
    matcher             = local.health_check_matcher
    timeout             = local.health_check_timeout
    path                = var.health_check_path
    unhealthy_threshold = local.health_check_unhealthy_threshold
  }
}

resource "aws_lb_target_group" "nextjs_frontend" {
  name        = "${local.target_group_name}-nextjs-frontend"
  port        = var.nextjs_frontend_port
  protocol    = local.protocol_http
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    healthy_threshold   = local.health_check_healthy_threshold
    interval            = local.health_check_interval
    protocol            = local.health_check_protocol
    port                = local.health_check_port
    matcher             = local.health_check_matcher
    timeout             = local.health_check_timeout
    path                = var.health_check_path
    unhealthy_threshold = local.health_check_unhealthy_threshold
  }
}

# HTTP listener
resource "aws_alb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.id
  port              = local.http_port
  protocol          = local.protocol_http

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Service Unavailable"
      status_code  = "503"
    }
  }

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nodejs_backend.arn
  }
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nextjs_frontend.arn
  }
}