# Creating the AWS ECR REPO
resource "aws_ecr_repository" "todo-ecr-repo" {
  name                 = var.ecr-repo-name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# Building the Docker Image
resource "docker_image" "todo_app_img" {
    name= "todoapp-img"

    build{
    context = "/workspaces/WEB_DEVELOPMENT/my-project/todoapp/"
    # Context should only have the path for the Directory where the Dockerfile is stored
    tag=["${aws_ecr_repository.todo-ecr-repo.repository_url}:${var.web_image_tag}"]
    }  
}

# Pushing image to ECR Repo
resource "docker_registry_image" "push_image" {
  name="${aws_ecr_repository.todo-ecr-repo.repository_url}:${var.web_image_tag}"
  depends_on = [ docker_image.todo_app_img ]
}
