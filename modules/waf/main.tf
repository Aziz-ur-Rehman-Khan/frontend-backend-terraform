resource "aws_wafv2_web_acl" "aws_wafv2_web_acl" {
  name  = var.name
  scope = var.scope

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.name}_Common_Protections"
    sampled_requests_enabled   = true
  }

  dynamic "rule" {
    for_each = [
      {
        name     = "AWS-AWSManagedRulesCommonRuleSet"
        priority = 1
        rule_set = "AWSManagedRulesCommonRuleSet"
      },
      {
        name     = "AWS-AWSManagedRulesLinuxRuleSet"
        priority = 2
        rule_set = "AWSManagedRulesLinuxRuleSet"
      },
      {
        name     = "AWS-AWSManagedRulesAmazonIpReputationList"
        priority = 3
        rule_set = "AWSManagedRulesAmazonIpReputationList"
      },
      {
        name     = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
        priority = 4
        rule_set = "AWSManagedRulesKnownBadInputsRuleSet"
      },
      {
        name     = "AWS-AWSManagedRulesSQLiRuleSet"
        priority = 5
        rule_set = "AWSManagedRulesSQLiRuleSet"
      }
    ]

    content {
      name     = rule.value.name
      priority = rule.value.priority

      override_action {
        none {}
      }

      statement {
        managed_rule_group_statement {
          name        = rule.value.rule_set
          vendor_name = "AWS"
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = rule.value.name
        sampled_requests_enabled   = true
      }
    }
  }

  tags = {
    enviornment = var.environment
  }

}

resource "aws_cloudwatch_log_group" "aws_waf_log_group" {
  name              = "aws-waf-logs-${var.name}"
  skip_destroy      = false
  retention_in_days = var.log_retention_in_days

}

resource "aws_wafv2_web_acl_logging_configuration" "aws_waf_logging_config" {
  log_destination_configs = [aws_cloudwatch_log_group.aws_waf_log_group.arn]
  resource_arn            = aws_wafv2_web_acl.aws_wafv2_web_acl.arn

  depends_on = [
    aws_wafv2_web_acl.aws_wafv2_web_acl,
    aws_cloudwatch_log_group.aws_waf_log_group
  ]
}
resource "aws_wafv2_web_acl_association" "WafwebAclAssociation" {
  for_each = { for idx, lb_arn in var.loadbalancer_arns : idx => lb_arn }

  resource_arn     = each.value
  web_acl_arn = aws_wafv2_web_acl.aws_wafv2_web_acl.arn

  depends_on = [
    aws_wafv2_web_acl.aws_wafv2_web_acl,
    aws_cloudwatch_log_group.aws_waf_log_group
  ]
}
