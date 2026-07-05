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

  execution_role_arn = "arn:aws:iam::926878603132:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name      = "threatmod"
      image     = "926878603132.dkr.ecr.eu-west-2.amazonaws.com/ecs-project:latest"
      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

# create service