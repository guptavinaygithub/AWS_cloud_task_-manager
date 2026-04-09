variable "project_name" {}
variable "vpc_id" {}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "alb_sg_id" {}
variable "ecs_sg_id" {}

variable "ecr_image_url" {}
variable "rds_endpoint" {}