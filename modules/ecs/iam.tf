data "aws_iam_policy_document" "ecs_tasks_execution_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "ecs_ssm_policy" {
  name        = "${var.environment}_ssm_policy"
  description = "SSM Policy for ECS Execute Commands"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect : "Allow",
        Action : [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ],
        Resource : "*"
      }
    ]
  })
}

resource "aws_iam_policy" "ecs_secrets_manager_policy" {
  name        = "${var.environment}_secrets_manager_policy"
  description = "Policy for ECS Tasks to Access Secrets in Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "secretsmanager:GetSecretValue",
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role" "ecs_tasks_execution_role" {
  name               = local.ecs_tasks_execution_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_execution_role.json
}

resource "aws_iam_role_policy_attachment" "ecs_tasks_execution_role" {
  role       = aws_iam_role.ecs_tasks_execution_role.name
  policy_arn = local.ecs_tasks_execution_policy_arn
}

resource "aws_iam_role_policy_attachment" "ecs_ssm_policy_attachment" {
  role       = aws_iam_role.ecs_tasks_execution_role.name
  policy_arn = aws_iam_policy.ecs_ssm_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_secret_access_policy_attachment" {
  role       = aws_iam_role.ecs_tasks_execution_role.name
  policy_arn = aws_iam_policy.ecs_secrets_manager_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecsCloudWatch_policy" {
  role       = aws_iam_role.ecs_tasks_execution_role.name
  policy_arn = local.ecs_cloudwatch_policy_arn
}

data "aws_iam_policy_document" "ecs_auto_scale_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_auto_scale_role" {
  name               = local.ecs_auto_scale_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_auto_scale_role.json
}

resource "aws_iam_role_policy_attachment" "ecs_auto_scale_role" {
  role       = aws_iam_role.ecs_auto_scale_role.name
  policy_arn = local.ecs_auto_scale_policy_arn
}
