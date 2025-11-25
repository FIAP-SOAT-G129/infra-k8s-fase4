variable "name" {
  description = "Base name for resources"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "tags" {
  description = "Default tags"
  type        = map(string)
  default     = {}
}
