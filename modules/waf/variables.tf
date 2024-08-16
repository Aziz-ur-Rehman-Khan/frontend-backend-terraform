variable "name" {
  description = "Name of the WAF ACL"
  type        = string
}

variable "scope" {
  description = "The scope of the WAF ACL (REGIONAL or CLOUDFRONT)"
  type        = string
}

variable "log_retention_in_days" {
  description = "Retention days for CloudWatch log group"
  type        = number
  default     = 180
}

variable "loadbalancer_arns" {
  description = "List of Load Balancer ARNs"
  type        = list(string)
}

variable "environment" {
  description = "Environment name, passed through workspace"
  type        = string
}