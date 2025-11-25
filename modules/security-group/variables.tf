variable "name" {
  type        = string
  description = "Base name for resources"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to deploy resources in"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "eks_from_port" {
  type        = number
  default     = 30080
  description = "The starting port for the security group rule EKS"
}

variable "eks_to_port" {
  type        = number
  default     = 30080
  description = "The ending port for the security group rule EKS"
}

variable "tags" {
  type    = map(string)
  default = {}
}
