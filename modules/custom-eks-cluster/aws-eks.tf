# EKS cluster

resource "aws_eks_cluster" "kvvTestTerraformEksCluster" {
  name      = var.eksClusterName
  role_arn  = aws_iam_role.kvvTestTerraformEksClusterRole.arn
  version   = "1.22"

  kubernetes_network_config {
    ip_family = "ipv4"
  }

  vpc_config {
    subnet_ids = local.publicSubnetsIds
    endpoint_public_access = true
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_route_table_association.rtAssociation,
    aws_iam_role_policy_attachment.attach-amazonEKSClusterPolicy-to-kvvTestTerraformEksClusterRole
  ]
}


# EKS node group

resource "aws_eks_node_group" "kvvTestTerraformEksClusterNodeGroup" {
  cluster_name    = aws_eks_cluster.kvvTestTerraformEksCluster.name
  node_group_name = var.eksClusterNodeGroupName
  node_role_arn   = aws_iam_role.kvvTestTerraformEKSNodeRole.arn
  subnet_ids      = local.publicSubnetsIds
  instance_types  = [var.nodeInstanceType]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  update_config {
    max_unavailable = 2
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.attach-amazonEKSWorkerNodePolicy-to-kvvTestTerraformEKSNodeRole,
    aws_iam_role_policy_attachment.attach-amazonEC2ContainerRegistryReadOnly-to-kvvTestTerraformEKSNodeRole,
    aws_iam_role_policy_attachment.attach-amazonEKS_CNI_Policy-to-kvvTestTerraformEKSNodeRole
  ]
}