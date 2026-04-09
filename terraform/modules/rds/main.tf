# Subnet Group
resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

# RDS Instance
resource "aws_db_instance" "this" {
  identifier              = "${var.project_name}-db"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20

  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password

  vpc_security_group_ids  = [var.rds_sg_id]
  db_subnet_group_name    = aws_db_subnet_group.this.name

  publicly_accessible     = false
  skip_final_snapshot     = true

  tags = {
    Name = "${var.project_name}-rds"
  }
}