output "vpc_id" {
  value = aws_vpc.ecs-vpc.id
}

output "public-subnet-1_id" {
  value = aws_subnet.public-subnet-1.id
}