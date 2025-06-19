output "ecr_repo_url" {
  value = aws_ecr_repository.todo-ecr-repo.repository_url
}

output "vpc_id" {
  value = module.vpc.vpc_id
  # naming convention : module Dir.sub-module Dir.Output_name used inside the outputs.tf in the module/vpc/
}

output "public_subnet_ids" {
  value = module.vpc.public-subnets
}