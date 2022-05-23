# +-+-+-+-+ +-+-+-+-+-+-+-+-+-+ +-+-+-+-+
# |*|*|*|*| |J|A|L|G|R|A|V|E|S| |*|*|*|*|
# +-+-+-+-+ +-+-+-+-+-+-+-+-+-+ +-+-+-+-+
# 2022

variable "name" {
  description = "Name of the ALB"
  type        = string
}

variable "certificate_arn" {}

variable "description" {
  description = "Description of ALB"
  type        = string
}
variable "env" {}
variable "vpc_id" {
  description = "vpc ID"
  type        = string
}

variable "region_code" {}
variable "security_groups" {
  description = "The security groups to attach the ALB"
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "A list of subnets to associate with the ALB"
  type        = list(string)
  default     = []
}

variable "target_groups" {
  description = "A list of maps that define the target groups to be created"
  type        = any
  default     = []
}

variable "enable_http2" {
  description = "Indicates whether HTTP/2 is enabled in ALB"
  type        = bool
  default     = false
}

variable "istio_nodeport" {
  description = "The nodeport that the Istio ingress gateway is listening on"
  default     = 30080
}

variable "create_lb" {
  description = "Controls if ALB should be created"
  type        = bool
  default     = false
}

variable "internal" {
  description = "Determines if ALB is internal or externally facing"
  type        = bool
  default     = false
}

variable "http_tcp_listeners" {
  description = "A list of maps describing the HTTP listeners or TCP ports for this ALB. Required key/values: port, protocol. Optional key/values: target_group_index (defaults to http_tcp_listeners[count.index])"
  type        = any
  default     = []
}

variable "control_plane_id" {}
