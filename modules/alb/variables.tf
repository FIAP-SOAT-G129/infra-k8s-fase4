variable "cluster_name" {
  description = "cluster Name"
  type        = string
}

variable "oidc_provider" {
  description = "OIDC provider URL do EKS"
  type        = string
}

variable "oidc_provider_arn" {
  description = "OIDC provider ARN do EKS"
  type        = string
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to deploy EKS cluster into"
}
