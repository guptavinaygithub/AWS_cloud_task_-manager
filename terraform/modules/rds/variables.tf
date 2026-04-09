variable "project_name" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}

variable "private_subnet_ids" {
  type = list(string)
}

variable "rds_sg_id" {}