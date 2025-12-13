module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.34.0"

  cluster_name                   = local.cluster_name
  cluster_endpoint_public_access = true
  authentication_mode            = "API"

  access_entries = {
    terraform_admin = {
      principal_arn = "arn:aws:iam::009093122732:user/github-user"
      access_policies = [
        "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
      ]
    }
  }

  create_kms_key = false
  cluster_encryption_config = []

  cluster_addons = {
    coredns = { most_recent = true }
    kube-proxy = { most_recent = true }
    vpc-cni = { most_recent = true }
  }

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

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
        # Essa label permite que o balancer.tf consiga atribuir o ingress como target no target groups da AWS
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