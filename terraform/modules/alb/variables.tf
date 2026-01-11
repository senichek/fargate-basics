variable "project" {}
variable "environment" {}

variable "public_subnet_ids" {
  description = "List of IDs of public subnets"
  type = list(string)
}

variable "alb-sg-id" {
  description = "Alb ecurity group ID"
  type = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}