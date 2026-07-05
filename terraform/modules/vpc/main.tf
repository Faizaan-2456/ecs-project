# Create vpc
resource "aws_vpc" "ecs-vpc" {
  cidr_block       = "10.0.0.0/16"
  region = var.region
  tags = {
    Name = "ecs-vpc"
  }
}


# Create public subnets
resource "aws_subnet" "public-subnet-1" {
  vpc_id     = aws_vpc.ecs-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.az_1

  tags = {
    Name = "public-subnet-1"
  }
}
resource "aws_subnet" "public-subnet-2" {
  vpc_id     = aws_vpc.ecs-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = var.az_2

  tags = {
    Name = "public-subnet-2"
  }
}


# Create Internet Gateway
resource "aws_internet_gateway" "ecs-gw" {
  vpc_id = aws_vpc.ecs-vpc.id

  tags = {
    Name = "ecs-gw"
  }
}


# Create public route table and route to igw
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.ecs-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecs-gw.id
  }

  tags = {
    Name = "public-rt"
  }
}


# Creates association between public subnets and public route table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public-2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-rt.id
}
