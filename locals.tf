locals {

  # General configuration
  current_workspace     = terraform.workspace
  current_aws_partition = data.aws_partition.current.id
  current_account_id    = data.aws_caller_identity.current.account_id

  availability_zones   = ["${var.region}a", "${var.region}b"]
  resource_prefix      = "${var.project_name}-${terraform.workspace}"
  resource_name_prefix = "${var.project_name}_${terraform.workspace}"


  # backend
  bucket_name                     = "xquic-terraform-state"
  dynamodb_table_name             = "terraform-state"
  sse_algorithm                   = "AES256"
  is_backend_s3_version_enabled   = "Enabled"
  dynamodb_hash_key_length        = 8
  backend_state_delete_protection = true
  block_public_acls               = true
  block_public_policy             = true
  ignore_public_acls              = true
  restrict_public_buckets         = true
  dynamodb_billing_mode           = "PAY_PER_REQUEST"
  dynamodb_hash_data_type         = "S"
  deletion_protection_enabled     = true




  # VPC module configuration
  vpc_name             = "${local.resource_prefix}-vpc"
  public_subnet_count  = 2
  private_subnet_count = 4
  nat_gateway_count    = 1




  # ECS module configurations
  environment_files = {
    "frontend-${terraform.workspace}" = "environmentfiles/frontend-${terraform.workspace}.env",
    "backend-${terraform.workspace}"  = "environmentfiles/backend-${terraform.workspace}.env",
    # Add more environment variables as needed
  }

  aws_region                   = "us-east-1"
  ec2_task_execution_role_name = "myEcsTaskExecutionRole"
  ecs_auto_scale_role_name     = "myEcsAutoScaleRole"
  availability_zones_count     = 2
  frontend_image               = "${module.ecr.repository_url}:${terraform.workspace}-frontend"
  backend_image                = "${module.ecr.repository_url}:${terraform.workspace}-backend"


  frontend_port                     = 80
  backend_port                      = 8080
  frontend_desired_count            = 1
  backend_desired_count             = 1
  health_check_path                 = "/health_check"
  frontend_fargate_cpu              = "2048"
  frontend_fargate_memory           = "4096"
  backend_fargate_cpu               = "1024"
  backend_fargate_memory            = "2048"
  frontend_autoscaling_min_capacity = 1
  frontend_autoscaling_max_capacity = 2
  backend_autoscaling_min_capacity  = 1
  backend_autoscaling_max_capacity  = 2


  # ECR module configuration
  force_delete            = false
  untagged_retention_days = 14
  tagged_retention_images = 30
  tag_prefixes            = ["staging", "production"]



}