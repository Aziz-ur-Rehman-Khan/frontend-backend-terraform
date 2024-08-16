output "load_balancer_endpoint" {
  value       = aws_lb.alb.dns_name
  description = "The DNS name of the Application Load Balancer (ALB)"
}
output "load_balancer_arn" {
  value       = aws_lb.alb.arn
  description = "The arn of the Application Load Balancer (ALB)"
}

output "ecs_tasks_sg_id" {
  value       = aws_security_group.ecs_tasks_sg.id
  description = "The ID of the security group associated with ECS tasks"
}
