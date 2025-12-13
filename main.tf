module "security_group" {
  source = "./modules/security-group"
  name   = var.name
  vpc_id = data.terraform_remote_state.foundation.outputs.vpc_id
  tags   = var.tags
}

module "eks" {
  source             = "./modules/eks"
  name               = var.name
  vpc_id             = data.terraform_remote_state.foundation.outputs.vpc_id
  subnet_ids         = data.terraform_remote_state.foundation.outputs.private_subnet_ids
  security_group_ids = module.security_group.eks_sg_id
  tags               = var.tags
}
