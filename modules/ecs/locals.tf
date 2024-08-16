locals {
  ecs_cluster_name              = "${var.prefix}-cluster"
  ecs_tasks_execution_role_name = "${var.prefix}-ecs-task-execution-role"
  ecs_auto_scale_role_name      = "${var.prefix}-ecs_auto_scale_role"
  frontend_service_resource     = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.frontend_service.name}"
  frontend_scale_up_name        = "${var.prefix}_scale_up"
  frontend_scale_down_name      = "${var.prefix}_scale_down"
  frontend_cpu_alarm_low        = "${var.prefix}_cpu_utilization_low"
  frontend_cpu_alarm_high       = "${var.prefix}_cpu_utilization_high"
  alb_sg_name                   = "${var.prefix}-load-balancer-security-group"
  ecs_tasks_sg_name             = "${var.prefix}-ecs-tasks-security-group"
  alb_name                      = "${var.prefix}-load-balancer"
  target_group_name             = "${var.prefix}-tg"


  backend_service_resource = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.backend_service.name}"
  backend_scale_up_name    = "${var.prefix}_backend_scale_up"
  backend_scale_down_name  = "${var.prefix}_backend_scale_down"
  backend_cpu_alarm_high   = "${var.prefix}_backend_cpu_utilization_high"
  backend_cpu_alarm_low    = "${var.prefix}_backend_cpu_utilization_low"


  alarm_metric_name        = "CPUUtilization"
  namespace                = "AWS/ECS"
  alarm_period             = 60
  alarm_statistic          = "Average"
  cpu_alarm_low_threshold  = 10
  cpu_alarm_high_threshold = 85

  ecs_tasks_execution_policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ecs_cloudwatch_policy_arn      = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  ecs_auto_scale_policy_arn      = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"


  alb_sg_description               = "Allow HTTP traffic"
  ecs_tasks_sg_description         = "Allow ECS task communication"
  protocol_all                     = "-1"
  protocol_tcp                     = "tcp"
  protocol_http                    = "HTTP"
  protocol_https                   = "HTTPS"
  all_port                         = 0
  http_port                        = 80
  https_port                       = 443
  mongodb_port                     = 27017
  cidr_all_ipv4                    = "0.0.0.0/0"
  health_check_healthy_threshold   = "5"
  health_check_interval            = "30"
  health_check_protocol            = local.protocol_http
  health_check_port                = "traffic-port"
  health_check_matcher             = "200"
  health_check_timeout             = "5"
  health_check_unhealthy_threshold = "5"

}
