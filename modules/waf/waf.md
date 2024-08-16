## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.aws_waf_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_wafv2_frontend_acl.aws_wafv2_frontend_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_frontend_acl) | resource |
| [aws_wafv2_frontend_acl_association.WaffrontendAclAssociation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_frontend_acl_association) | resource |
| [aws_wafv2_frontend_acl_logging_configuration.aws_waf_logging_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_frontend_acl_logging_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name, passed through workspace | `string` | n/a | yes |
| <a name="input_loadbalancer_arns"></a> [loadbalancer\_arns](#input\_loadbalancer\_arns) | List of Load Balancer ARNs | `list(string)` | n/a | yes |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | Retention days for CloudWatch log group | `number` | `180` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the WAF ACL | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | The scope of the WAF ACL (REGIONAL or CLOUDFRONT) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_frontend_acl_arn"></a> [frontend\_acl\_arn](#output\_frontend\_acl\_arn) | The ARN of the WAF frontendACL. |
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.aws_waf_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_wafv2_frontend_acl.aws_wafv2_frontend_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_frontend_acl) | resource |
| [aws_wafv2_frontend_acl_association.WaffrontendAclAssociation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_frontend_acl_association) | resource |
| [aws_wafv2_frontend_acl_logging_configuration.aws_waf_logging_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_frontend_acl_logging_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name, passed through workspace | `string` | n/a | yes |
| <a name="input_loadbalancer_arns"></a> [loadbalancer\_arns](#input\_loadbalancer\_arns) | List of Load Balancer ARNs | `list(string)` | n/a | yes |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | Retention days for CloudWatch log group | `number` | `180` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the WAF ACL | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | The scope of the WAF ACL (REGIONAL or CLOUDFRONT) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_frontend_acl_arn"></a> [frontend\_acl\_arn](#output\_frontend\_acl\_arn) | The ARN of the WAF frontendACL. |
