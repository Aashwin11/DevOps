resource "aws_ecs_task_definition" "this" {
  family = "multi-container-task"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu=512
  memory = 1024
  execution_role_arn = var.execution-role-arn
  task_role_arn = var.task-role-arn


  container_definitions = templatefile("/workspaces/WEB_DEVELOPMENT/my-project/terraform-ecr-ecs/modules/ecs/container-definitions.json.tpl",{
    web_image_url=var.web-image-url
    mongo_image=var.mongo-image
    efs_mount_name=var.efs-volume-name
    efs_id=var.efs_file_system_id
  })

  volume {
    name = var.efs-volume-name

    efs_volume_configuration {
      file_system_id          = var.efs_file_system_id
      root_directory          = "/"
      transit_encryption      = "ENABLED"
    }
  }
}
resource "aws_ecs_service" "this" {
  name            = "web-api-service"
  cluster         = var.cluster-name
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired-count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnet-ids
    security_groups = var.security-group-ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target-group-arn
    container_name   = "web-api"
    container_port   = 5000
  }

  depends_on = [aws_ecs_task_definition.this]
}