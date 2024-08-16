variable "prefix" {
  description = "The Prefix attached with the relevent resources in ECS Module"
  type        = string
}
variable "vpc_id" {
  description = "The AWS VPC for ECS related resources"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of private subnet IDs where the Redis cluster will be deployed."
  type        = list(string)
}
variable "private_subnet_ids" {
  description = "List of private subnet IDs where the Redis cluster will be deployed."
  type        = list(string)
}
variable "frontend_secrets" {
  description = "Output from the AWS Secrets Manager module"

}

variable "backend_secrets" {
  description = "Output from the AWS Secrets Manager module"

}
variable "aws_region" {
  description = "The AWS region things are created in"
  type        = string
}

variable "ec2_task_execution_role_name" {
  description = "ECS task execution role name"
  default     = "myEcsTaskExecutionRole"
  type        = string
}

variable "ecs_auto_scale_role_name" {
  description = "ECS auto scale role name"
  default     = "myEcsAutoScaleRole"
  type        = string
}

variable "availability_zones_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
  type        = number
}

variable "frontend_image" {
  description = "Docker image for frontend to run in the ECS cluster"
  type        = string
}

variable "backend_image" {
  description = "Docker image for backend to run in the ECS cluster"
  type        = string
}

variable "nextjs_frontend_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
  type        = number
}

variable "nodejs_backend_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 8080
  type        = number
}

variable "frontend_desired_count" {
  description = "Desired Task count for frontendapp ECS Service"
  default     = 1
  type        = number
}
variable "backend_desired_count" {
  description = "Desired Task count for frontendapp ECS Service"
  default     = 1
  type        = number
}
variable "health_check_path" {
  default = "/health_check"
  type    = string
}

variable "frontend_fargate_cpu" {
  description = "Fargate instance CPU units for frontendapp (1 vCPU = 1024 CPU units)"
  default     = "2048"
  type        = string
}

variable "frontend_fargate_memory" {
  description = "Fargate instance memory for frontendapp (in MiB)"
  default     = "4096"
  type        = string
}

variable "backend_fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
  type        = string
}

variable "backend_fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
  type        = string
}

variable "environment" {
  description = "ECS Environment"
  type        = string
}

variable "frontend_min_capacity" {
  description = "Minimum capacity for autoscaling frontendapp ecs service"
  type        = number
  default     = 1
}

variable "frontend_max_capacity" {
  description = "Maximum capacity for autoscaling frontendapp ecs service"
  type        = number
  default     = 3
}
variable "backend_min_capacity" {
  description = "Minimum capacity for autoscaling frontendapp ecs service"
  type        = number
  default     = 1
}

variable "backend_max_capacity" {
  description = "Maximum capacity for autoscaling frontendapp ecs service"
  type        = number
  default     = 3
}
