output "alb-sg" {
  value = aws_security_group.alb-sg.id
}

output "ecs_target_group" {
  value = aws_lb_target_group.ecs_target_group.arn
}

output "alb_dns_name" {
  value = aws_lb.ecs_project_alb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.ecs_project_alb.zone_id
}