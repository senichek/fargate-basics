variable "project" {}
variable "environment" {}
variable "execution_role_arn" {
    description = "Arn of execution role"
    type = string
}

variable "logs_region" {
  description = "Cloudwatch logs region"
  type        = string
}

variable "logs-group-name" {
  description = "Name of Cloudwatch logs group"
  type        = string
}

variable "ecr-repo-name" {
  description = "Name of ECR repository"
  type        = string
}
