# Create ecs cluster
resource "aws_ecs_cluster" "ecs-project" {
  name = "ecs-project"
}

# Create task definition
resource "aws_ecs_task_definition" "ecs-td" {
  family                   = "ecs-td"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  cpu    = "1024"
  memory = "3072"

  execution_role_arn = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = var.image_name
      image     = var.image
      essential = true

      portMappings = [
        {
          containerPort = 3000
          protocol = "tcp"
        }
      ]
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}


# Create security group
resource "aws_security_group" "service_sg" {
  name        = "service-sg"
  description = "allowing traffic from container port"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow traffic from container port"
  }
}


resource "aws_vpc_security_group_ingress_rule" "service_sg_ingress" {
  security_group_id = aws_security_group.service_sg.id
  referenced_security_group_id = var.alb-sg
  from_port         = 3000
  ip_protocol       = "tcp"
  to_port           = 3000
}

resource "aws_vpc_security_group_egress_rule" "service_sg_egress" {
  security_group_id = aws_security_group.service_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


# Create service
resource "aws_ecs_service" "ecs_td_service" {
  name            = "ecs-td-service"
  cluster         = aws_ecs_cluster.ecs-project.id
  task_definition = aws_ecs_task_definition.ecs-td.id
  desired_count   = 3
  launch_type = "FARGATE"


 network_configuration {
    security_groups = [aws_security_group.service_sg.id]
    subnets = [var.public-subnet-1, var.public-subnet-2]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.ecs_target_group
    container_name   = "threatmod"
    container_port   = 3000
  }
}