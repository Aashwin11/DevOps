output "alb-sg-id" {
  description = "Decurity Group ID of the ALB"
  value = aws_security_group.alb-sg.id
}

output "target-group-arn" {
  description = "ARN of the target group"
  value = aws_lb_target_group.app-tg.arn
}