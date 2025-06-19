resource "aws_efs_mount_target" "this" {
  count = length(var.subnet-ids)
  file_system_id = aws_efs_file_system.this.id
  subnet_id = element(var.subnet-ids,count.index)
  security_groups = [aws_security_group.efs_sg.id]
}