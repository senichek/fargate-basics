variable "project" {}
variable "environment" {}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC cidr block"
  type        = string
}
