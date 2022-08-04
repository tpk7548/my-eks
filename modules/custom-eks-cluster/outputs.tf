output "nodeGroupSubnetsAwsIdsOutput" {
  value = local.publicSubnetsIds
  description = "AWS IDs of the created subnets"
}

output "eksEndpoint" {
  value = aws_eks_cluster.kvvTestTerraformEksCluster.endpoint
  description = "The IP address of the main server instance."
}

# output "kubeconfigCertificateAuthorityData" {
#   value = aws_eks_cluster.kvvTestTerraformEksCluster.certificate_authority[0].data
#   description = "The private IP address of the main server instance."
# }


