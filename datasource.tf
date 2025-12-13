data "terraform_remote_state" "foundation" {
  backend = "s3"
  config = {
    bucket = "fastfood-tf-states"
    key    = "infra/foundation/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_eks_cluster_auth" "eks_cluster" {
  name = module.eks.cluster_name
}