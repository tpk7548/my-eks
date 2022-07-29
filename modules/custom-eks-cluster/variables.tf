variable "vpcCidrBlock" {
  description = "VPC CIDR block"
  type        = string
}

variable "subnetList" {
  description = "The list of three subnets"
  type        = list(string)
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