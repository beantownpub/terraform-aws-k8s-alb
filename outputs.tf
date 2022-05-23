# +-+-+-+-+ +-+-+-+-+-+-+-+-+-+ +-+-+-+-+
# |*|*|*|*| |J|A|L|G|R|A|V|E|S| |*|*|*|*|
# +-+-+-+-+ +-+-+-+-+-+-+-+-+-+ +-+-+-+-+
# 2022

output "alb" {
  value = module.alb
}

output "dns_name" {
  value = module.alb.lb_dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.kubernetes.arn
}
