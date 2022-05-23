# +-+-+-+-+ +-+-+-+-+-+-+-+-+-+ +-+-+-+-+
# |*|*|*|*| |J|A|L|G|R|A|V|E|S| |*|*|*|*|
# +-+-+-+-+ +-+-+-+-+-+-+-+-+-+ +-+-+-+-+
# 2022

module "network" {
  source  = "app.terraform.io/beantown/network/aws"
  version = "0.1.5"

  availability_zones              = var.availability_zones[data.aws_region.current.name]
  create_ssh_sg                   = true
  default_security_group_deny_all = false
  environment                     = var.env
  cidr_block                      = "10.0.0.0/16"
  internet_gateway_enabled        = true
  label_create_enabled            = true
  nat_gateway_enabled             = false
  nat_instance_enabled            = false
  region_code                     = "usw2"
}

module "alb" {
  source = "../.."

  certificate_arn  = aws_acm_certificate.cert.arn
  control_plane_id = module.ec2.instance.id
  description      = "ALB created via Terraform"
  env              = "pilot"
  name             = "pilot-usw2"
  region_code      = "usw2"
  security_groups  = []
  subnets          = module.network.public_subnet_ids
  vpc_id           = module.network.vpc_id
}
