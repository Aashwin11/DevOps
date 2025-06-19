resource "aws_security_group" "efs_sg" {
  name="todo-efs-sg"
  description = "Allow NFS from ECS SG to EFS "
  vpc_id = var.vpc-id

  ingress{
    from_port=2049
    to_port=2049
    protocol="tcp"
    security_groups=[var.ecs-sg-id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags={
    Name="todo-efs-sg"
  }
}