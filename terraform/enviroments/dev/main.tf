
provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../../modules/vpc"

  project_name            = var.project_name
  vpc_cidr                = var.vpc_cidr
  public_subnet_1_cidr    = "10.0.1.0/24"
  public_subnet_2_cidr    = "10.0.2.0/24"
  private_subnet_1_cidr   = "10.0.3.0/24"
  private_subnet_2_cidr   = "10.0.4.0/24"
  az_1                    = "ap-south-1a"
  az_2                    = "ap-south-1b"
}

module "security_groups" {
  source = "../../modules/security-groups"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "rds" {
  source = "../../modules/rds"

  project_name      = var.project_name
  db_name           = "taskdb"
  db_username       = "admin"
  db_password       = "Admin1234"

  private_subnet_ids = module.vpc.private_subnet_ids
  rds_sg_id          = module.security_groups.rds_sg_id
}

module "ecs_alb" {
  source = "../../modules/ecs-alb"

  project_name        = var.project_name
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  private_subnet_ids  = module.vpc.private_subnet_ids

  alb_sg_id = module.security_groups.alb_sg_id
  ecs_sg_id = module.security_groups.ecs_sg_id

  ecr_image_url = "505415189319.dkr.ecr.ap-south-1.amazonaws.com/cloud-task-mana-repo"
  rds_endpoint  = module.rds.rds_endpoint
}
