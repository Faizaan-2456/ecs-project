terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.52.0"
    }
  }


backend "s3" {
    bucket       = "ecsprojects"
    key          = "ecs-project/terraform.tfstate"
    region       = "eu-west-2"
  }
}

provider "aws" {
  # Configuration options
}