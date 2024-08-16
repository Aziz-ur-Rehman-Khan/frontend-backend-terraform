output "web_acl_arn" {
  description = "The ARN of the WAF webACL."
  value       = aws_wafv2_web_acl.aws_wafv2_web_acl.arn
}