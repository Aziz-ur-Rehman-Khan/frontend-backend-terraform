output "frontend_secrets" {
  description = "Provides the mapping of frontend secrets stored in AWS Secrets Manager, including their names and ARNs."
  value = [
    for key, secret in aws_secretsmanager_secret.frontend_env_secrets : {
      name      = key
      valueFrom = secret.arn
    }
  ]
}

output "backend_secrets" {
  description = "Provides the mapping of backend secrets stored in AWS Secrets Manager, including their names and ARNs."
  value = [
    for key, secret in aws_secretsmanager_secret.backend_env_secrets : {
      name      = key
      valueFrom = secret.arn
    }
  ]
}