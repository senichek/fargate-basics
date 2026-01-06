locals {
  project        = "fargate-demo"
  environment    = "dev"
}

module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr_block       = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones   = ["eu-west-1a", "eu-west-1b"]
  project              = local.project
  environment          = local.environment
}

module "ecr" {
  source               = "./modules/ecr"
  project              = local.project
  environment          = local.environment
}

module "iam" {
  source               = "./modules/iam"
  project              = local.project
  environment          = local.environment
}

module "ecs-cluster" {
  source               = "./modules/ecs_cluster"
  project              = local.project
  environment          = local.environment
}
