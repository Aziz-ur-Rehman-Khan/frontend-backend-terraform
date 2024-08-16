# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC created by the module"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets created by the module"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets created by the module"
  value       = module.vpc.private_subnet_ids
}

# ECR Outputs
output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = module.ecr.repository_url
}
# Secret Manager Outputs
output "frontend_secrets_arn" {
  description = "The ARN of the AWS Secrets Manager environment secrets"
  value       = module.secrets_manager.frontend_secrets
}

output "backend_secrets_arn" {
  description = "The ARN of the AWS Secrets Manager environment secrets"
  value       = module.secrets_manager.backend_secrets
}

# # Terraform State Outputs
# output "terraform_state_s3_bucket_arn" {
#   description = "The ARN of the S3 bucket"
#   value       = aws_s3_bucket.terraform_state.arn
# }

# output "dynamodb_table_name" {
#   description = "The name of the DynamoDB table"
#   value       = aws_dynamodb_table.terraform_state.name
# }
