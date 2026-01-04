resource "aws_iam_role" "this" {
  name = "${var.project}-${var.environment}-role"

  # Set up trust relationships.
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "${var.project}-${var.environment}-role"
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Attach the AWS-managed policy
resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
