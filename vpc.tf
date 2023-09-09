provider "aws" {
  region = "us-east-1"
}

module "myapp-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.64.0"

  name = "test-eks-vpc"
  cidr = var.vpc_cidr_block
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets = var.public_subnet_cidr_blocks
  azs = data.aws_availability_zones.azs.names

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true

  tags = {
      "kubernetes.io/cluster/test-eks-cluster" = "shared"   #AWS cloud controller manager to identity the our cluster
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/test-eks-cluster" = "shared"
    "kubernetes.io/role/elb" = 1     #Cluster to identify public subnet for provisioning public Elastic load balancer 
  }

  private_subnet_tags = {
      "kubernetes.io/cluster/test-eks-cluster" = "shared"
      "kubernetes.io/role/internal-elb" = 1   #Cluster to identify private subnet for provisioning private Elastic load balancer 
  }
  
}

data "aws_availability_zones" "azs" {}

variable "vpc_cidr_block" {}
variable "private_subnet_cidr_blocks" {}
variable "public_subnet_cidr_blocks" {}