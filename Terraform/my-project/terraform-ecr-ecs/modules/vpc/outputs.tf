output "vpc_id" {
  value = aws_vpc.main-VPC.id
}

output "public-subnets" {
  value=aws_subnet.public-SUBNET[*].id
}