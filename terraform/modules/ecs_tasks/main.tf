resource "aws_ecs_task_definition" "this" {
  family                   = "flask-fargate-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = var.execution_role_arn
  task_role_arn      = null

  container_definitions = jsonencode([
    {
      name      = "flask-app"
      image     = "${var.ecr-repo-name}"
      essential = true

      portMappings = [
        {
          containerPort = 8080
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "${var.logs-group-name}"
          awslogs-region        = "${var.logs_region}"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  tags = {
    Name        = "${var.project}-${var.environment}-ecs-task-definition"
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
