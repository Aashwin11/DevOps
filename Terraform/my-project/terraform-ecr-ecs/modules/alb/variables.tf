variable "vpc-id" {
  description = "VPC ID for ALB"
}

variable "public-subnet-ids" {
  description = "List of Public Subnet IDs"
  type=list(string)
}
