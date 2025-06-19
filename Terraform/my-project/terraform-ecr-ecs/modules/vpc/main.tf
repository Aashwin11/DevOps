resource "aws_vpc" "main-VPC" {
    cidr_block = var.vpc_cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
      Name="todo-VPC"
    }
}

resource "aws_subnet" "public-SUBNET" {
    vpc_id = aws_vpc.main-VPC.id
    count = length(var.public_subnet_cidrs)
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = var.availability_zone[count.index]
    map_public_ip_on_launch = true

    tags={
        Name="todo-PUBLIC-SUBNET ${count.index}"
    }

}

resource "aws_internet_gateway" "igw-VPC" {
    vpc_id = aws_vpc.main-VPC.id
     tags={
        Name="todo-IGW"
    }
}


resource "aws_route_table" "todo-RT" {
    vpc_id = aws_vpc.main-VPC.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw-VPC.id
    }
}

resource "aws_route_table_association" "todo-RTA" {
  count = length(aws_subnet.public-SUBNET)
  subnet_id = aws_subnet.public-SUBNET[count.index].id
  route_table_id = aws_route_table.todo-RT.id
}