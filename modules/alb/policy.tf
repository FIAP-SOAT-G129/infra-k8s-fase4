resource "aws_iam_policy" "alb_controller" {
  name        = "fastfood-alb-controller-policy"
  description = "IAM policy for AWS Load Balancer Controller"

  policy = jsonencode(
    jsondecode(file("${path.module}/alb-controller-policy.json"))
  )
}
