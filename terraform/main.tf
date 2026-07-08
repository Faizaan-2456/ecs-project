module "vpc" {
  source = "./modules/vpc"
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  aws_security_group = module.alb.alb-sg
  public-subnet-1 = module.vpc.public-subnet-1_id
  public-subnet-2 = module.vpc.public-subnet-2_id
  certificate_arn = module.route53.certificate_arn
}

module "ecs" {
  source = "./modules/ecs"
  public-subnet-1 = module.vpc.public-subnet-1_id
  public-subnet-2 = module.vpc.public-subnet-2_id
  vpc_id = module.vpc.vpc_id
  ecs_target_group = module.alb.ecs_target_group
  alb-sg = module.alb.alb-sg
}

module "route53" {
  source = "./modules/route53"
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id = module.alb.alb_zone_id
}