terraform {
  backend "s3" {
    bucket               = "test-eks-tfstate"
    key                  = "App/test-eks-tfstate.tfstate"
    region               = "us-east-1"
  }
}