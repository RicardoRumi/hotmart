resource "aws_security_group" "ecs_sg" {
  name        = "${local.ecs.service_name}-sg"
  description = "Allow inbound traffic to ECS tasks from the ALB"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    description      = "Allow HTTP from ALB"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb_sg.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.ecs.service_name}-sg"
  }
}