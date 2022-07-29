variable "vpcCidrBlock" {
  description = "VPC CIDR block"
  type        = string
}

variable "subnetList" {
  description = "List of three subnets"
  type        = list(string)
}