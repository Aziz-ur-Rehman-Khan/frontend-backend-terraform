data "aws_partition" "current" {}

data "aws_caller_identity" "current" {}

module "vpc" {

  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  vpc_name             = local.vpc_name
  prefix               = local.resource_prefix
  public_subnet_count  = local.public_subnet_count
  private_subnet_count = local.private_subnet_count
  availability_zones   = local.availability_zones
  nat_gateway_count    = local.nat_gateway_count
}


module "ecs" {
  source                       = "./modules/ecs"
  prefix                       = local.resource_prefix
  public_subnet_ids            = module.vpc.public_subnet_ids
  vpc_id                       = module.vpc.vpc_id
  private_subnet_ids           = module.vpc.private_subnet_ids
  frontend_secrets             = module.secrets_manager.frontend_secrets
  backend_secrets              = module.secrets_manager.backend_secrets
  aws_region                   = local.aws_region
  ec2_task_execution_role_name = local.ec2_task_execution_role_name
  ecs_auto_scale_role_name     = local.ecs_auto_scale_role_name
  availability_zones_count     = local.availability_zones_count
  backend_image                = local.backend_image
  frontend_image               = local.frontend_image
  nodejs_backend_port          = local.backend_port
  nextjs_frontend_port         = local.frontend_port
  frontend_desired_count       = local.frontend_desired_count
  backend_desired_count        = local.backend_desired_count
  health_check_path            = local.health_check_path
  frontend_fargate_cpu         = local.frontend_fargate_cpu
  frontend_fargate_memory      = local.frontend_fargate_memory
  backend_fargate_cpu          = local.backend_fargate_cpu
  backend_fargate_memory       = local.backend_fargate_memory
  environment                  = terraform.workspace
  frontend_min_capacity        = local.frontend_autoscaling_min_capacity
  backend_min_capacity         = local.backend_autoscaling_min_capacity
  backend_max_capacity         = local.backend_autoscaling_max_capacity

}
module "ecr" {
  source                  = "./modules/ecr"
  ecr_name                = local.resource_prefix
  force_delete            = local.force_delete
  untagged_retention_days = local.untagged_retention_days
  tagged_retention_images = local.tagged_retention_images
  tag_prefixes            = local.tag_prefixes
}
module "secrets_manager" {
  source      = "./modules/secret_manager"
  env_files   = local.environment_files
  environment = terraform.workspace

}

module "waf" {
  source                = "./modules/waf"
  name                  = "${local.resource_prefix}-wafv2-frontend-acl"
  scope                 = "REGIONAL"
  environment           = terraform.workspace
  log_retention_in_days = 30
  loadbalancer_arns     = [module.ecs.load_balancer_arn]
}
