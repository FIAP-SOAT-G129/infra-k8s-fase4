resource "helm_release" "alb_controller" {
  name      = "aws-load-balancer-controller"
  namespace = "kube-system"

  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"

  depends_on = [
    kubernetes_service_account.alb
  ]

set = [
  {
    name  = "clusterName"
    value = var.name
  },
  {
    name  = "vpcId"
    value = var.vpc_id
  },
  {
    name  = "serviceAccount.create"
    value = "false"
  },
  {
    name  = "serviceAccount.name"
    value = kubernetes_service_account.alb.metadata[0].name
  }
]
}
