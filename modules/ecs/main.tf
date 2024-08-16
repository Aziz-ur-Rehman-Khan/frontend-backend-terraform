resource "aws_ecs_cluster" "ecs_cluster" {
  name = local.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "frontend_taskdefinition" {
  family                   = "frontend-task"
  execution_role_arn       = aws_iam_role.ecs_tasks_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_tasks_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.frontend_fargate_cpu
  memory                   = var.frontend_fargate_memory
  container_definitions    = data.template_file.frontend_task_definition.rendered
}

resource "aws_ecs_task_definition" "backend_taskdefinition" {
  family                   = "backend-task"
  execution_role_arn       = aws_iam_role.ecs_tasks_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_tasks_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.backend_fargate_cpu
  memory                   = var.backend_fargate_memory
  container_definitions    = data.template_file.backend_task_definition.rendered
}


resource "aws_ecs_service" "frontend_service" {
  name                   = "frontend-service"
  cluster                = aws_ecs_cluster.ecs_cluster.id
  task_definition        = aws_ecs_task_definition.frontend_taskdefinition.arn
  desired_count          = var.frontend_desired_count
  enable_execute_command = true
  launch_type            = "FARGATE"
  lifecycle {
    ignore_changes = [desired_count]
  }


  network_configuration {
    security_groups = [aws_security_group.ecs_tasks_sg.id]
    subnets         = var.private_subnet_ids
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.nextjs_frontend.id
    container_name   = "frontend"
    container_port   = var.nextjs_frontend_port
  }

  depends_on = [aws_iam_role_policy_attachment.ecs_tasks_execution_role]
}

resource "aws_ecs_service" "backend_service" {
  name                   = "backend"
  cluster                = aws_ecs_cluster.ecs_cluster.id
  task_definition        = aws_ecs_task_definition.backend_taskdefinition.arn
  desired_count          = var.backend_desired_count
  launch_type            = "FARGATE"
  enable_execute_command = true
  lifecycle {
    ignore_changes = [desired_count]
  }

  network_configuration {
    security_groups = [aws_security_group.ecs_tasks_sg.id]
    subnets         = var.private_subnet_ids
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.nodejs_backend.id
    container_name   = "backend"
    container_port   = var.nodejs_backend_port
  }

  depends_on = [aws_iam_role_policy_attachment.ecs_tasks_execution_role]
}

