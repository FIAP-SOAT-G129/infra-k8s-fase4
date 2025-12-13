module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = local.cluster_name
  cluster_version = "1.29"

  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  authentication_mode = "API_AND_CONFIG_MAP"

  enable_irsa = true
  vpc_id      = var.vpc_id
  subnet_ids  = var.subnet_ids

  create_kms_key            = false
  cluster_encryption_config = []

  cluster_addons = {
    aws-ebs-csi-driver = {
      service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
    }
  }

  eks_managed_node_group_defaults = {
    ami_type       = var.ami_type
    instance_types = var.instance_types

    node_security_group_tags = {
      "kubernetes.io/cluster/${var.name}-cluster" = null
    }
  }

  eks_managed_node_groups = {
    ingress-nodegroup = {
      node_group_name = "ingress-nginx-nodegroup"
      min_size        = var.min_size
      max_size        = var.max_size
      desired_size    = var.desired_size
      instance_types  = var.instance_types
      capacity_type   = "SPOT"

      labels = {
        app = "ingress-nodegroup"
      }

      security_groups = var.security_group_ids
    }

    orders-service = {
      min_size       = var.min_size
      max_size       = var.max_size
      desired_size   = var.desired_size
      instance_types = var.instance_types
      capacity_type  = "SPOT"

      labels = {
        app = "orders-api-app"
      }

      security_groups = var.security_group_ids
    }

    payments-service = {
      min_size       = var.min_size
      max_size       = var.max_size
      desired_size   = var.desired_size
      instance_types = var.instance_types
      capacity_type  = "SPOT"

      labels = {
        app = "payments-api-app"
      }

      security_groups = var.security_group_ids
    }

    catalog-service = {
      min_size       = var.min_size
      max_size       = var.max_size
      desired_size   = var.desired_size
      instance_types = var.instance_types
      capacity_type  = "SPOT"

      labels = {
        app = "catalog-api-app"
      }

      security_groups = var.security_group_ids
    }
  }

  tags = merge(
    var.tags,
    {
      Name      = "${var.name}-eks"
      Terraform = "true"
    }
  )
}

module "irsa-ebs-csi" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.39.0"

  create_role                   = true
  role_name                     = "AmazonEKSTFEBSCSIRole-${module.eks.cluster_name}"
  provider_url                  = module.eks.oidc_provider
  role_policy_arns              = [data.aws_iam_policy.ebs_csi_policy.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
}
