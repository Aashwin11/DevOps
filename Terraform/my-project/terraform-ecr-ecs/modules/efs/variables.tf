variable "vpc-id" {
  type=string
}

variable "subnet-ids" {
  type = list(string)
}
variable "ecs-sg-id" {
  type = string
}