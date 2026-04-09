# ECS Cluster
resource "aws_ecs_cluster" "this" {
  name = "${var.project_name}-cluster"
}

# ALB
resource "aws_lb" "this" {
  name               = "${var.project_name}-alb"
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [var.alb_sg_id]
}

# Target Group
resource "aws_lb_target_group" "this" {
  name        = "${var.project_name}-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path     = "/tasks"
    protocol = "HTTP"
    matcher  = "200"
  }
}

# Listener
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

# Task Definition
resource "aws_ecs_task_definition" "this" {
  family                   = "${var.project_name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "arn:aws:iam::505415189319:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name      = "backend"
      image     = var.ecr_image_url
      essential = true
      portMappings = [{
        containerPort = 8080
        protocol      = "tcp"
      }]
      environment = [
  {
    name  = "SPRING_DATASOURCE_URL"
    value = "jdbc:mysql://${var.rds_endpoint}/taskdb"
  },
  {
    name  = "SPRING_DATASOURCE_USERNAME"
    value = "admin"
  },
  {
    name  = "SPRING_DATASOURCE_PASSWORD"
    value = "Admin1234"
  }
]
    }
  ])
}

# ECS Service
resource "aws_ecs_service" "this" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.ecs_sg_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = "backend"
    container_port   = 8080
  }

  depends_on = [aws_lb_listener.this]
}