variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "task_family" {
  type        = string
  default     = "my-task-family" # Replace with your task family name
  description = "Name of the ECS task family"
}

variable "ecr_values" {
  type        = any
  default     = {}
  description = "AWS ECR configuration"
}

variable "ecs_values" {
  type        = any
  default     = {}
  description = "AWS ECS configuration"
}

variable "lb_values" {
  type        = any
  default     = {}
  description = "AWS Load Balancer configuration"
}

variable "vpc" {
  type        = any
  default     = {}
  description = "AWS VPC configuration"
}

variable "container" {
  type        = any
  default     = {}
  description = "Container configuration to deploy"
}
