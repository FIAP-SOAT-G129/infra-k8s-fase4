variable "name" {
  type        = string
  description = "Base name for resources"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to deploy EKS cluster into"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for the EKS worker nodes"
}

variable "ami_type" {
  type        = string
  description = "EKS managed node group AMI type"
  default     = "AL2_x86_64"
}

variable "instance_types" {
  type        = list(string)
  description = "List of EC2 instance types for the EKS managed node group"
  default     = ["t3.small"]
}

variable "desired_size" {
  type        = number
  description = "Desired number of nodes"
  default     = 1
}

variable "min_size" {
  type        = number
  description = "Minimum number of nodes"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Maximum number of nodes"
  default     = 2
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with the RDS instance"
}
