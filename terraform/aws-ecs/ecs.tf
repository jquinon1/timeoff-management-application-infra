resource "aws_ecs_cluster" "main" {
    name = "${var.environment}-${var.project_name}-ecs"
}

resource "aws_ecs_task_definition" "main" {
    family = "main"
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu                      = 256
    memory                   = 512
    execution_role_arn       = "arn:aws:iam::651144116335:role/ecsTaskExecutionRole"
    task_role_arn            = aws_iam_role.ecs_task_role.arn
    container_definitions = jsonencode([{
     name        = "${var.environment}-container-${var.project_name}"
     image       = "${local.container_url}:latest"
     essential   = true
     portMappings = [{
        protocol      = "tcp"
        containerPort = var.container_port
        hostPort      = var.container_port
     }]
    }])
}

resource "aws_ecs_service" "main" {
    name                               = "${var.environment}-service-${var.project_name}"
    cluster                            = aws_ecs_cluster.main.id
    task_definition                    = aws_ecs_task_definition.main.arn
    desired_count                      = 2
    deployment_minimum_healthy_percent = 50
    deployment_maximum_percent         = 200
    launch_type                        = "FARGATE"
    scheduling_strategy                = "REPLICA"
    
    network_configuration {
        security_groups  = [aws_security_group.ecs_svc_sg.id]
        subnets          = local.private_subnets
        assign_public_ip = false
    }
    
    load_balancer {
        target_group_arn = local.target_group_arns[0]
        container_name   = "${var.environment}-container-${var.project_name}"
        container_port   = var.container_port
    }
    
    lifecycle {
        ignore_changes = [task_definition, desired_count]
    }
}