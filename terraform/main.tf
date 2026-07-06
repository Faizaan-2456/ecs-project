module "vpc" {
  source = "./modules/vpc"
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  aws_security_group = module.alb.alb-sg
  public-subnet-1 = module.vpc.public-subnet-1_id
}

module "ecs" {
  source = "./modules/ecs"
}