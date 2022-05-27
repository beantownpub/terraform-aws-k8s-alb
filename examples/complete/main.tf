# +-+-+-+-+ +-+-+-+-+-+-+-+-+-+ +-+-+-+-+
# |*|*|*|*| |J|A|L|G|R|A|V|E|S| |*|*|*|*|
# +-+-+-+-+ +-+-+-+-+-+-+-+-+-+ +-+-+-+-+
# 2022

resource "aws_acm_certificate" "cert" {
  domain_name       = "*.test.jalgraves.com"
  validation_method = "DNS"
  tags = {
    Zone = "jalgraves.com"
  }
  lifecycle {
    create_before_destroy = true
  }
}

module "network" {
  source  = "app.terraform.io/beantown/network/aws"
  version = "0.1.5"

  availability_zones              = ["us-west-2a", "us-west-2b"]
  create_ssh_sg                   = true
  default_security_group_deny_all = false
  environment                     = "test"
  cidr_block                      = "10.0.0.0/16"
  internet_gateway_enabled        = true
  label_create_enabled            = true
  nat_gateway_enabled             = false
  nat_instance_enabled            = false
  region_code                     = "usw2"
}

module "alb" {
  source = "../.."

  certificate_arn = aws_acm_certificate.cert.arn
  description     = "ALB created via Terraform"
  env             = "test"
  name            = "test-usw2"
  region_code     = "usw2"
  security_groups = []
  subnets         = module.network.public_subnet_ids
  vpc_id          = module.network.vpc_id
}
