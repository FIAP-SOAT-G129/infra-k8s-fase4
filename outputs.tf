output "vpc_id" {
  description = "VPC ID where the EKS cluster is deployed"
  value       = data.terraform_remote_state.foundation.outputs.vpc_id
}

output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "alb_controller_role_arn" {
  description = "IAM Role ARN for AWS Load Balancer Controller"
  value       = module.alb.alb_controller_role_arn
}
