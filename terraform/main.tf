module "vpc" {
  source = "./modules/vpc"
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
}