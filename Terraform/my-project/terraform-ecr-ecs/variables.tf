variable "aws-region" {
  description = "region of aws"
  default = "us-east-1"
}
variable "image_name" {
description = "name of the DOcker image in ECS"
default = "todo-app"
}

variable "ecr-repo-name" {
  description = "name of the ecr repo"
  default = "todo-app-repo"
}

variable "web_image_tag" {
  type        = string
  description = "Tag of the web API Docker image"
  default     = "latest" # or no default if you want to enforce it
}

//vpc 

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "availability_zone" {
  default = ["us-east-1a","us-east-1b"]
}