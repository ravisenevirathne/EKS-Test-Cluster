terraform {
  required_providers {
    aws = {
        version = "4.21.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.6"
    }
    kubernetes = {
        version = "2.12.1"
    }
  }
  //required_version = "~> 1.2.6"
}

provider "helm" {
    kubernetes {
        host                   = data.aws_eks_cluster.test-eks-cluster.endpoint
        cluster_ca_certificate = base64decode(data.aws_eks_cluster.test-eks-cluster.certificate_authority.0.data)
            exec {
                api_version = "client.authentication.k8s.io/v1beta1"
                args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.test-eks-cluster.name]
                command     = "aws"
            }
    }
}


provider "kubernetes" {
    host                   = data.aws_eks_cluster.test-eks-cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.test-eks-cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.test-eks-cluster.token
    #load_config_file       = false
}




data "aws_eks_cluster" "test-eks-cluster" {
  name = "test-eks-cluster"
}

data "aws_eks_cluster_auth" "test-eks-cluster" {
  name = "test-eks-cluster"
}