resource "aws_security_group" "alb-sg" {
    name="alb-sg"
    description = "Allow http from anywhere to ALB"
    vpc_id = var.vpc-id

    ingress{
        description = "Allow http to hit ALB from anywhere"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name="alb-sg"
    }
}