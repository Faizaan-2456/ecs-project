variable "vpc_id" {
  description = "vpc id"
  type = string
}

variable "aws_security_group" {
  description = "alb security group"
  type = string
}

variable "public-subnet-1" {
  description = "public subnet 1"
  type = string
}

variable "public-subnet-2" {
  description = "public-subnet-2"
  type = string
}

variable "allow_all_traffic_ipv4" {
    description = "cidr 0.0.0.0/0 allow all traffic"
    type = string
    default = "0.0.0.0/0"
  
}
