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

resource "aws_lb_target_group" "kubernetes" {
  name     = "kubernetes"
  port     = istio_nodeport
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/healthz"
    port                = istio_nodeport
    healthy_threshold   = 6
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "404"
  }
  tags = {
    Name = "kubernetes"
    Role = "alb"
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
    target_group_arn = aws_lb_target_group.kubernetes.arn
  }
  tags = {
    Name = "frontend-https"
    Role = "alb"
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
    Role = "alb"
  }
}

resource "aws_lb_target_group_attachment" "control_plane" {
  target_group_arn = aws_lb_target_group.kubernetes.arn
  target_id        = var.control_plane_id
  port             = istio_nodeport
}

