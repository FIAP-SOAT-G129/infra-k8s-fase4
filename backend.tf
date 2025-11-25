terraform {
  backend "s3" {
    bucket = "fastfood-tf-states"
    key    = "infra/k8s/terraform.tfstate"
    region = "us-east-1"
  }
}
