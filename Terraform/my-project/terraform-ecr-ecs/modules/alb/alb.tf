resource "aws_alb" "app-alb" {
  name="todo-app-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb-sg.id]
subnets = var.public-subnet-ids

tags = {
  Name="todo-app-alb"
}
}

resource "aws_lb_target_group" "app-tg" {
    name="todo-app-tg"
    port=5000
    protocol = "HTTP"
    vpc_id = var.vpc-id
    target_type = "ip"

    health_check {
      path = "/health"
      interval = 30
      timeout = 5
      healthy_threshold = 2
      unhealthy_threshold = 2
      matcher = "200-399"
    }

    tags = {
      Name="todo-app-tg"
    }
}

resource "aws_lb_listener" "http-listener" {
  load_balancer_arn = aws_alb.app-alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type="forward"
    target_group_arn = aws_lb_target_group.app-tg.arn
  }
}