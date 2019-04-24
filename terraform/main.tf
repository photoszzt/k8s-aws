provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "fission-kubernetes-log"
    key    = "dev/terraform"
    region = "us-east-1"
  }
}

locals {
  azs                    = ["us-east-1a", "us-east-1c", "us-east-1d"]
  environment            = "fission-kubernetes"
  kops_state_bucket_name = "${local.environment}-statestore"
  // Needs to be a FQDN
  kubernetes_cluster_name = "fission.k8s.local"
  ingress_ips             = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  vpc_name                = "${local.environment}-vpc"

  tags = {
    environment = "${local.environment}"
    terraform   = true
  }
}

data "aws_region" "current" {}
