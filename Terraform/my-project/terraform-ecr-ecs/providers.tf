terraform{
    required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
  backend "local" {
    path = "terraform.tfstate"
  }

}

provider "aws" {
    region = var.aws-region 
}



data "aws_ecr_authorization_token" "token"{}

provider "docker" {
  host = "unix:///var/run/docker.sock"
  
  registry_auth{
    address=data.aws_ecr_authorization_token.token.proxy_endpoint
    username=data.aws_ecr_authorization_token.token.user_name
    password=data.aws_ecr_authorization_token.token.password
  }
}
