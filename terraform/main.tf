locals {
  project        = "fargate-demo"
  environment    = "dev"
  region         = "eu-west-1"
  aws_account    = "xxxxxxxxxxx"
  logs_region    = local.region
  ecr_repo_name  = "${local.aws_account}.dkr.ecr.${local.region}.amazonaws.com/${local.project}-${local.environment}-ecr:latest"
  vpc_cidr_block = "10.0.0.0/16"
}

module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr_block       = local.vpc_cidr_block
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones   = ["eu-west-1a", "eu-west-1b"]
  project              = local.project
  environment          = local.environment
}

module "security_group" {
  source         = "./modules/security_group"
  project        = local.project
  environment    = local.environment
  vpc_id         = module.vpc.vpc_id
  vpc_cidr_block = local.vpc_cidr_block
}

module "ecr" {
  source      = "./modules/ecr"
  project     = local.project
  environment = local.environment
}

module "iam" {
  source      = "./modules/iam"
  project     = local.project
  environment = local.environment
}

module "ecs-cluster" {
  source      = "./modules/ecs_cluster"
  project     = local.project
  environment = local.environment
}

module "cloudwatch" {
  source      = "./modules/cloudwatch"
  project     = local.project
  environment = local.environment
}

module "ecs_task" {
  source             = "./modules/ecs_tasks"
  project            = local.project
  environment        = local.environment
  logs_region        = local.logs_region
  execution_role_arn = module.iam.execution_role_arn
  logs-group-name    = module.cloudwatch.cloudwatch-log-group-name
  ecr-repo-name      = local.ecr_repo_name
}

module "alb" {
  source            = "./modules/alb"
  project           = local.project
  environment       = local.environment
  public_subnet_ids = module.vpc.public_subnet_ids
  alb-sg-id         = module.security_group.alb_sg_id
  vpc_id            = module.vpc.vpc_id
}
