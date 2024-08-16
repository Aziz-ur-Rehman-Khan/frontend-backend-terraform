data "template_file" "frontend_task_definition" {
  template = file("${path.module}/templates/frontend_task_definition.json.tpl")

  vars = {
    frontend_image   = var.frontend_image
    cpu              = 0
    port_frontend    = var.nextjs_frontend_port
    secrets          = jsonencode(var.frontend_secrets)
    log_group_prefix = "/ecs/"
    aws_region       = "us-east-1"
  }
}


data "template_file" "backend_task_definition" {
  template = file("${path.module}/templates/backend_task_definition.json.tpl")

  vars = {
    backend_image    = var.backend_image
    cpu              = 0
    port_backend     = var.nodejs_backend_port
    secrets          = jsonencode(var.backend_secrets)
    log_group_prefix = "/ecs/"
    aws_region       = "us-east-1"
  }
}

resource "aws_ecs_task_definition" "frontend" {
  family                = "frontend-task"
  container_definitions = data.template_file.frontend_task_definition.rendered
}

resource "aws_ecs_task_definition" "backend" {
  family                = "backend-task"
  container_definitions = data.template_file.backend_task_definition.rendered
}
