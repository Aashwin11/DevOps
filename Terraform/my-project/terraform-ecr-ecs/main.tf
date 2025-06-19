# In the module/vpc/ 
# main.tf has -> vpc (we have associated vpc CIDR Block eg:10.0.0.0/16)
#             -> whcih all public subnets associated with the VPC (list of subnets)
#             -> Availability zone for the public subnets

module "vpc" {
  source="/workspaces/WEB_DEVELOPMENT/my-project/terraform-ecr-ecs/modules/vpc"
  vpc_cidr_block=var.vpc_cidr_block
  public_subnet_cidrs=var.public_subnet_cidrs
  availability_zone=var.availability_zone
}

module "alb" {
  source = "/workspaces/WEB_DEVELOPMENT/my-project/terraform-ecr-ecs/modules/alb"
  vpc-id=module.vpc.vpc_id
  public-subnet-ids=module.vpc.public-subnets
}
module "ecs" {
  source="/workspaces/WEB_DEVELOPMENT/my-project/terraform-ecr-ecs/modules/ecs_cluster"
  vpc-id=module.vpc.vpc_id
  alb-sg-id=module.alb.alb-sg-id
  ecs-sg-name="todo-ecs-sg"

}
module "efs"{
  source="/workspaces/WEB_DEVELOPMENT/my-project/terraform-ecr-ecs/modules/efs"
  vpc-id= module.vpc.vpc_id
  ecs-sg-id=module.ecs.ecs-sg-id
  subnet-ids=module.vpc.public-subnets
}

module "iam" {
  source = "/workspaces/WEB_DEVELOPMENT/my-project/terraform-ecr-ecs/modules/iam"
}

module "ecs-td" {
  source = "/workspaces/WEB_DEVELOPMENT/my-project/terraform-ecr-ecs/modules/ecs"
  task-role-arn        = module.iam.ecs_task_role_arn
  execution-role-arn   = module.iam.ecs_task_execution_role_arn
  web-image-url        = "${aws_ecr_repository.todo-ecr-repo.repository_url}:${var.web_image_tag}"
  mongo-image          = "mongo:6.0"
  efs-volume-name      = module.efs.efs-volume-name
  efs_file_system_id   = module.efs.efs-id
  cluster-name         = module.ecs.ecs-cluster-name
  desired-count        = 2
  subnet-ids           = module.vpc.public-subnets
  security-group-ids   = [module.ecs.ecs-sg-id]
  target-group-arn     = module.alb.target-group-arn
}
