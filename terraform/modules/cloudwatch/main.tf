resource "aws_cloudwatch_log_group" "this" {
  name              = "${var.project}-${var.environment}-ecs"
  retention_in_days = 7

  tags = {
    Name        = "${var.project}-${var.environment}-ecs"
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
