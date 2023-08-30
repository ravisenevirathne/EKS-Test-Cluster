module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.21.0"
  
  cluster_name = "test-eks-cluster"
  cluster_version = "1.24"

  subnet_ids = module.myapp-vpc.private_subnets

  vpc_id = module.myapp-vpc.vpc_id

  tags = {
      environment = "development"
      application = "test"
  }

 eks_managed_node_groups = {
     dev = {
     min_size = 1
     max_size = 3
     desired_size = 1
     instance_types = ["t2.medium"]
     } 
 }
}