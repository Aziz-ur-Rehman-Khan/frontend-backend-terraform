variable "project_name" {
  type        = string
  description = "The name of the project or application associated with this infrastructure."
}

variable "region" {
  type        = string
  description = "The AWS region where the infrastructure will be deployed (e.g., 'us-east-1', 'eu-west-1')."
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the Virtual Private Cloud (VPC) to be created."
}
variable "aws_profiles" {
  description = "A map of AWS profiles corresponding to different environments"
  type        = map(string)
  default = {
    default    = "staging"
    staging    = "staging"
    production = "production"
    dev        = "dev"
  }
}

