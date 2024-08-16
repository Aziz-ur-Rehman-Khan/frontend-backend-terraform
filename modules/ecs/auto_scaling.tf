resource "aws_appautoscaling_target" "target" {
  service_namespace  = "ecs"
  resource_id        = local.frontend_service_resource
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = aws_iam_role.ecs_auto_scale_role.arn
  min_capacity       = var.frontend_min_capacity
  max_capacity       = var.frontend_max_capacity
  depends_on         = [aws_ecs_service.frontend_service]
}

resource "aws_appautoscaling_policy" "up" {
  name               = local.frontend_scale_up_name
  service_namespace  = "ecs"
  resource_id        = local.frontend_service_resource
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }

  depends_on = [aws_appautoscaling_target.target]
}

resource "aws_appautoscaling_policy" "down" {
  name               = local.frontend_scale_down_name
  service_namespace  = "ecs"
  resource_id        = local.frontend_service_resource
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = -1
    }
  }

  depends_on = [aws_appautoscaling_target.target]
}

resource "aws_cloudwatch_metric_alarm" "service_cpu_high" {
  alarm_name          = local.frontend_cpu_alarm_high
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = local.alarm_metric_name
  namespace           = local.namespace
  period              = local.alarm_period
  statistic           = local.alarm_statistic
  threshold           = local.cpu_alarm_high_threshold

  dimensions = {
    ClusterName = aws_ecs_cluster.ecs_cluster.name
    ServiceName = aws_ecs_service.frontend_service.name
  }

  alarm_actions = [aws_appautoscaling_policy.up.arn]
}

resource "aws_cloudwatch_metric_alarm" "service_cpu_low" {
  alarm_name          = local.frontend_cpu_alarm_low
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = local.alarm_metric_name
  namespace           = local.namespace
  period              = local.alarm_period
  statistic           = local.alarm_statistic
  threshold           = local.cpu_alarm_low_threshold

  dimensions = {
    ClusterName = aws_ecs_cluster.ecs_cluster.name
    ServiceName = aws_ecs_service.frontend_service.name
  }

  alarm_actions = [aws_appautoscaling_policy.down.arn]
}

# backend Autoscaling Config

resource "aws_appautoscaling_target" "backend_target" {
  service_namespace  = "ecs"
  resource_id        = local.backend_service_resource
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = aws_iam_role.ecs_auto_scale_role.arn
  min_capacity       = var.backend_min_capacity
  max_capacity       = var.backend_max_capacity
  depends_on         = [aws_ecs_service.backend_service]
}

resource "aws_appautoscaling_policy" "backend_up" {
  name               = local.backend_scale_up_name
  service_namespace  = "ecs"
  resource_id        = local.backend_service_resource
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }

  depends_on = [aws_appautoscaling_target.backend_target]
}

resource "aws_appautoscaling_policy" "backend_down" {
  name               = local.backend_scale_down_name
  service_namespace  = "ecs"
  resource_id        = local.backend_service_resource
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = -1
    }
  }

  depends_on = [aws_appautoscaling_target.backend_target]
}

resource "aws_cloudwatch_metric_alarm" "backend_service_cpu_high" {
  alarm_name          = local.backend_cpu_alarm_high
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = local.alarm_metric_name
  namespace           = local.namespace
  period              = local.alarm_period
  statistic           = local.alarm_statistic
  threshold           = local.cpu_alarm_high_threshold

  dimensions = {
    ClusterName = aws_ecs_cluster.ecs_cluster.name
    ServiceName = aws_ecs_service.backend_service.name
  }

  alarm_actions = [aws_appautoscaling_policy.backend_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "backend_service_cpu_low" {
  alarm_name          = local.backend_cpu_alarm_low
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = local.alarm_metric_name
  namespace           = local.namespace
  period              = local.alarm_period
  statistic           = local.alarm_statistic
  threshold           = local.cpu_alarm_low_threshold

  dimensions = {
    ClusterName = aws_ecs_cluster.ecs_cluster.name
    ServiceName = aws_ecs_service.backend_service.name
  }

  alarm_actions = [aws_appautoscaling_policy.backend_down.arn]
}

