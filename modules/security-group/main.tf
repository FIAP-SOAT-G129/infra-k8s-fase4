resource "aws_security_group" "eks_sg" {
  name        = "${var.name}-eks-node-sg"
  description = "Security Group para o cluster EKS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8082
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name                                        = "${var.name}-eks-node-sg",
      "kubernetes.io/cluster/${var.name}-cluster" = "owned"
    }
  )
}

# Security Group para o NLB do Ingress
resource "aws_security_group" "ingress_nlb_sg" {
  name        = "ingress-nlb-sg"
  description = "Security group for the Ingress NLB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    var.tags,
    {
      Name = "${var.name}-ingress-nlb-sg",
    }
  )

}