resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${var.task_family}" # Replace var.task_family with a specific name if needed
  retention_in_days = 7                         # Optional: Set the number of days to retain logs
  tags = {
    Environment = "production"
  }
}
