# security_groups.tf

resource "aws_security_group" "alb_sg" {
  name        = "${local.lb.name}-sg"
  description = "Allow inbound HTTP traffic to the ALB"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.lb.name}-sg"
  }
}
