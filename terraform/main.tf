# VPC Module
module "vpc" {
  source = "./modules/vpc"
  project_name = var.project_name
  environment = var.environment
  vpc_cidr_block = var.vpc_cidr_block
}


# Web App Module
module "web_app" {
  source = "./modules/web_app"
  project_name = var.project_name
  environment = var.environment
  web_app_instance_type = var.web_app_instance_type
  ami_id = var.ami_id
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  allow_ips = var.allow_ips
  default_user = var.default_user
  app_local_path = abspath("${path.root}/..")
}
