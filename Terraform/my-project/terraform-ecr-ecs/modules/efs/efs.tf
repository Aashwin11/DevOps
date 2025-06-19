resource "aws_efs_file_system" "this" {
  creation_token = "todo-efs"
  encrypted = true
  tags = {
    Name="todo-efs"
  }
}