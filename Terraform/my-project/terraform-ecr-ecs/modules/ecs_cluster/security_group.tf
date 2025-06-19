resource "aws_security_group" "ecs-sg" {
  name=var.ecs-sg-name
  description = "Allow from ALB to ECS 5000 and self on 27017"
    vpc_id = var.vpc-id

# Inbound for http
   ingress{
    description = "Allow from ALB to port 5000"
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
    security_groups = [var.alb-sg-id]

   } 
#Inbound for mongo 
  ingress{
    description = "Allow from ECS SG  to port 27017, mongo access"
    from_port = 27017
    to_port = 27017
    protocol    = "tcp"
    self            = true

   } 

   egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
     Name=var.ecs-sg-name
   }
}   

