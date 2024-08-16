resource "aws_secretsmanager_secret" "frontend_env_secrets" {
  for_each = local.frontend_environment_variables

  name                    = "frontend-${var.environment}-${each.key}"
  recovery_window_in_days = 0
  tags = {
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "frontend_env_secret_versions" {
  for_each      = local.frontend_environment_variables
  secret_id     = aws_secretsmanager_secret.frontend_env_secrets[each.key].id
  secret_string = each.value
}


resource "aws_secretsmanager_secret" "backend_env_secrets" {
  for_each = local.backend_environment_variables

  name                    = "backend-${var.environment}-${each.key}"
  recovery_window_in_days = 0
  tags = {
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "backend_env_secret_versions" {
  for_each      = local.backend_environment_variables
  secret_id     = aws_secretsmanager_secret.backend_env_secrets[each.key].id
  secret_string = each.value
}
