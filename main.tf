module "security_group" {
  source = "./modules/security-group"
  name   = var.name
  vpc_id = data.terraform_remote_state.foundation.outputs.vpc_id
  tags   = var.tags
}

module "eks" {
  source     = "./modules/eks"
  name       = var.name
  vpc_id     = data.terraform_remote_state.foundation.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.foundation.outputs.private_subnet_ids
  tags       = var.tags
}

module "alb" {
  source            = "./modules/alb"
  name              = module.eks.cluster_name
  vpc_id            = data.terraform_remote_state.foundation.outputs.vpc_id
  oidc_provider     = module.eks.oidc_provider
  oidc_provider_arn = module.eks.oidc_provider_arn
}
