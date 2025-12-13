output "eks_sg_id" {
  description = "The ID of the security group associated with the EKS"
  value       = aws_security_group.eks_sg.id
}