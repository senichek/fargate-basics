resource "aws_ecr_repository" "this" {
  name                 = "${var.project}-${var.environment}-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "${var.project}-${var.environment}-ecr"
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

