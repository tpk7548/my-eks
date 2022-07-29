terraform {
  required_version = ">= 1.2.2"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket         = "test-terraform-state-backend"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_state"
  }
}

provider "aws" {
  region = "us-east-1"
}

module my-eks-cluster {
  source = "./modules/custom-eks-cluster"

  vpcCidrBlock = var.vpcCidrBlock
  subnetList   = var.subnetList

  eksClusterName          = "kvvTestTerraformEksCluster"
  eksClusterNodeGroupName = "kvvTestTerraformEksClusterNodeGroup"
  nodeInstanceType        = "t3a.small"
}