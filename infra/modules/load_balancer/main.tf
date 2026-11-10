# Configuración del balanceador de carga para la API de la app de pedidos
# Superficie de práctica: implementar la configuración del balanceador

resource "aws_lb" "app_alb" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets

  enable_deletion_protection = var.enable_deletion_protection

  tags = {
    Name        = var.alb_name
    Environment = var.environment
    Project     = "pedidos-app"
  }
}

resource "aws_lb_target_group" "app_tg" {
  name     = var.target_group_name
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = var.health_check_path
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name        = var.target_group_name
    Environment = var.environment
  }
}

resource "aws_lb_listener" "app_https" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  ssl_policy      = var.ssl_policy
  certificate_arn = var.certificate_arn
}

resource "aws_lb_listener_rule" "api_path" {
  listener_arn = aws_lb_listener.app_https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}