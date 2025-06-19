variable "vpc-id" {
  description = "vpc id for ECS SG"
  type = string
}
variable "ecs-sg-name" {
  description = "Name of ECS security group"
  type = string
}

variable "alb-sg-id" {
  description = "Security Group for ALB"
  type=string
}