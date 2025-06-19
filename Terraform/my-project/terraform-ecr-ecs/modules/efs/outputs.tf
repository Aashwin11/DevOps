output "efs-id" {
  value = aws_efs_file_system.this.id
}

output "efs-sg-id" {
  value = aws_security_group.efs_sg.id
}
output "efs-volume-name" {
  value = aws_efs_file_system.this.name
}