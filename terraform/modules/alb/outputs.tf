output "alb-sg" {
  value = aws_security_group.alb-sg.id
}

output "ecs_target_group" {
  value = aws_lb_target_group.ecs_target_group.arn
}