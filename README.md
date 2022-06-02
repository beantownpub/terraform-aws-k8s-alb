# terraform-aws-k8s-alb
Terraform module to create an AWS Application Load Balancer (ALB) for a Kubernetes cluster

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | terraform-aws-modules/alb/aws | ~> 6.3 |

## Resources

| Name | Type |
|------|------|
| [aws_lb_listener.frontend_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.frontend_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.kubernete_api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.kubernetes_api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.kubernetes_workers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | n/a | `any` | n/a | yes |
| <a name="input_create_lb"></a> [create\_lb](#input\_create\_lb) | Controls if ALB should be created | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of ALB | `string` | n/a | yes |
| <a name="input_enable_http2"></a> [enable\_http2](#input\_enable\_http2) | Indicates whether HTTP/2 is enabled in ALB | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `any` | n/a | yes |
| <a name="input_http_tcp_listeners"></a> [http\_tcp\_listeners](#input\_http\_tcp\_listeners) | A list of maps describing the HTTP listeners or TCP ports for this ALB. Required key/values: port, protocol. Optional key/values: target\_group\_index (defaults to http\_tcp\_listeners[count.index]) | `any` | `[]` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | Determines if ALB is internal or externally facing | `bool` | `false` | no |
| <a name="input_istio_healthcheck_nodeport"></a> [istio\_healthcheck\_nodeport](#input\_istio\_healthcheck\_nodeport) | The nodeport for healthchecking istio-ingress | `number` | `32382` | no |
| <a name="input_istio_nodeport"></a> [istio\_nodeport](#input\_istio\_nodeport) | The nodeport that the Istio ingress gateway is listening on | `number` | `30080` | no |
| <a name="input_kubernetes_api_port"></a> [kubernetes\_api\_port](#input\_kubernetes\_api\_port) | n/a | `number` | `6443` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the ALB | `string` | n/a | yes |
| <a name="input_region_code"></a> [region\_code](#input\_region\_code) | n/a | `any` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | The security groups to attach the ALB | `list(string)` | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A list of subnets to associate with the ALB | `list(string)` | `[]` | no |
| <a name="input_target_groups"></a> [target\_groups](#input\_target\_groups) | A list of maps that define the target groups to be created | `any` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb"></a> [alb](#output\_alb) | n/a |
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | n/a |
| <a name="output_kubernetes_api_target_group_arn"></a> [kubernetes\_api\_target\_group\_arn](#output\_kubernetes\_api\_target\_group\_arn) | n/a |
| <a name="output_kubernetes_workers_target_group_arn"></a> [kubernetes\_workers\_target\_group\_arn](#output\_kubernetes\_workers\_target\_group\_arn) | n/a |
<!-- END_TF_DOCS -->
