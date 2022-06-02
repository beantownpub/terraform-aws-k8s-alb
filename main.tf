# +-+-+-+-+ +-+-+-+-+-+-+-+-+-+ +-+-+-+-+
# |*|*|*|*| |J|A|L|G|R|A|V|E|S| |*|*|*|*|
# +-+-+-+-+ +-+-+-+-+-+-+-+-+-+ +-+-+-+-+
# 2022

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.3"

  internal           = var.internal
  name               = var.name
  vpc_id             = var.vpc_id
  security_groups    = var.security_groups
  subnets            = var.subnets
  target_groups      = var.target_groups
  http_tcp_listeners = var.http_tcp_listeners
  tags = {
    Name = var.name
    Role = "alb"
  }
}

resource "aws_lb_target_group" "kubernetes_api" {
  name     = "kubernetes-api"
  port     = var.kubernetes_api_port
  protocol = "HTTPS"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/healthz"
    port                = var.kubernetes_api_port
    protocol            = "HTTPS"
    healthy_threshold   = 6
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "200"
  }
  tags = {
    Name = "kubernetes-api"
  }
}

resource "aws_lb_target_group" "kubernetes_workers" {
  name     = "kubernetes-workers"
  port     = var.istio_nodeport
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/healthz/ready"
    port                = var.istio_healthcheck_nodeport
    healthy_threshold   = 6
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "200"
  }
  tags = {
    Name = "kubernetes-workers"
  }
}

resource "aws_lb_listener" "kubernete_api" {
  load_balancer_arn = module.alb.lb_arn
  port              = var.kubernetes_api_port
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kubernetes_api.arn
  }
  tags = {
    Name = "kubernetes-api"
  }
}

resource "aws_lb_listener" "frontend_https" {
  load_balancer_arn = module.alb.lb_arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kubernetes_workers.arn
  }
  tags = {
    Name = "frontend-https"
  }
}

resource "aws_lb_listener" "frontend_http" {
  load_balancer_arn = module.alb.lb_arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
  tags = {
    Name = "frontend-http"
  }
}
