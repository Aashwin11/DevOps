variable "vpc_cidr_block" { 
    description = "CIDR BLOCK of VPC"
    type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "availability_zone" {
  type = list(string)
}
