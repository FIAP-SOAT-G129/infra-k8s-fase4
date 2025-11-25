module "security_group" {
  source         = "./modules/security-group"
  name           = var.name
  vpc_id         = data.terraform_remote_state.foundation.outputs.vpc_id
  vpc_cidr_block = data.terraform_remote_state.foundation.outputs.vpc_cidr_block
  tags           = var.tags
}

module "eks" {
  source     = "./modules/eks"
  name       = var.name
  vpc_id     = data.terraform_remote_state.foundation.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.foundation.outputs.private_subnet_ids
  tags       = var.tags
}
