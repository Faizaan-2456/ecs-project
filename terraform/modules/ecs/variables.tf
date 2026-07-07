variable "public-subnet-1" {
  description = "public subnet 1"
  type = string
}

variable "public-subnet-2" {
  description = "public subnet 2"
  type = string
}

variable "vpc_id" {
  description = "ecs vpc"
  type = string
}

variable "ecs_target_group" {
  description = "alb target group"
  type = string
}

variable "alb-sg" {
  description = "alb sg"
  type = string
}