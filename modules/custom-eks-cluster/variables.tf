variable "vpcCidrBlock" {
  description = "VPC CIDR block"
  type        = string
}

variable "subnetsMap" {
  description = "Public subnets, mapped to AZs"
  type        = map(map(string))
}

variable "eksClusterName" {
  description = "The name of EKS Cluster"
  type        = string
}

variable "eksClusterNodeGroupName" {
  description = "The name of EKS Cluster Node Group"
  type        = string
}

variable "nodeInstanceType" {
  description = "The type of EKS Cluster Node Instance"
  type        = string
}