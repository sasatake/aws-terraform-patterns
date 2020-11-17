resource "aws_ecs_cluster" "nginx" {
  name = "${var.prefix}-ecscls-nginx"
}

resource "aws_ecs_service" "nginx" {
  name            = "${var.prefix}-ecssrv-nginx"
  cluster         = aws_ecs_cluster.nginx.id
  desired_count   = 1
  task_definition = aws_ecs_task_definition.nginx.arn

  network_configuration {
    subnets          = [aws_subnet.public-subnet-01.id]
    security_groups  = [aws_security_group.sg-ecs-nginx.id]
    assign_public_ip = true
  }

  capacity_provider_strategy {
    base              = 0
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}

resource "aws_ecs_task_definition" "nginx" {
  family                   = "${var.prefix}-ecstask-nginx"
  container_definitions    = file("${path.module}/templates/ecs/task-definitions-nginx.json")
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  network_mode             = "awsvpc"

  lifecycle {
    ignore_changes = [container_definitions]
  }
}
