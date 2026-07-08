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

variable "execution_role_arn" {
  description = "arn for task execution role"
  type = string
  default = "arn:aws:iam::926878603132:role/ecsTaskExecutionRole"
}

variable "image" {
  description = "docker image id"
  type = string
  default = "926878603132.dkr.ecr.eu-west-2.amazonaws.com/ecs-project:latest"
}

variable "image_name" {
    description = "image name"
    type = string
    default = "threatmod"
}