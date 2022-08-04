variable "vpcCidrBlock" {
  description = "VPC CIDR block"
  type        = string
}

variable "subnetsMap" {
  description = "Public subnets, mapped to AZs"
  type        = map(map(string))
}