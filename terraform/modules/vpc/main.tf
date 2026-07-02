# Create VPC

resource "aws_vpc" "ecs-vpc" {
  cidr_block       = "10.0.0.0/16"
  region = var.region
  tags = {
    Name = "ecs-vpc"
  }
}


# Create subnets
resource "aws_subnet" "public-subnet-1" {
  vpc_id     = aws_vpc.ecs-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public-subnet-1"
  }
}
resource "aws_subnet" "public-subnet-2" {
  vpc_id     = aws_vpc.ecs-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public-subnet-2"
  }
}
resource "aws_subnet" "private-subnet-1" {
  vpc_id     = aws_vpc.ecs-vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "private-subnet-1"
  }
}
resource "aws_subnet" "private-subnet-2" {
  vpc_id     = aws_vpc.ecs-vpc.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "private-subnet-2"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "ecs-gw" {
  vpc_id = aws_vpc.ecs-vpc.id

  tags = {
    Name = "ecs-gw"
  }
}

# Create route tables
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.ecs-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecs-gw.id
  }

  tags = {
    Name = "example"
  }
}