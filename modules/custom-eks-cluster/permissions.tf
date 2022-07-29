# EksClusterRole

resource "aws_iam_role" "kvvTestTerraformEksClusterRole" {
  name = "kvvTerraformTestEksClusterRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
})

  tags = {
    Name = "kvvTestTerraformEksClusterRole"
  }
}

data "aws_iam_policy" "amazonEKSClusterPolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "attach-amazonEKSClusterPolicy-to-kvvTestTerraformEksClusterRole" {
  role       = aws_iam_role.kvvTestTerraformEksClusterRole.name
  policy_arn = data.aws_iam_policy.amazonEKSClusterPolicy.arn
}


# EKSNodeRole

resource "aws_iam_role" "kvvTestTerraformEKSNodeRole" {
  name = "kvvTerraformTestEKSNodeRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
})

  tags = {
    Name = "kvvTestTerraformEKSNodeRole"
  }
}

data "aws_iam_policy" "amazonEKSWorkerNodePolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}
resource "aws_iam_role_policy_attachment" "attach-amazonEKSWorkerNodePolicy-to-kvvTestTerraformEKSNodeRole" {
  role       = aws_iam_role.kvvTestTerraformEKSNodeRole.name
  policy_arn = data.aws_iam_policy.amazonEKSWorkerNodePolicy.arn
}

data "aws_iam_policy" "amazonEC2ContainerRegistryReadOnly" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
resource "aws_iam_role_policy_attachment" "attach-amazonEC2ContainerRegistryReadOnly-to-kvvTestTerraformEKSNodeRole" {
  role       = aws_iam_role.kvvTestTerraformEKSNodeRole.name
  policy_arn = data.aws_iam_policy.amazonEC2ContainerRegistryReadOnly.arn
}

data "aws_iam_policy" "amazonEKS_CNI_Policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
resource "aws_iam_role_policy_attachment" "attach-amazonEKS_CNI_Policy-to-kvvTestTerraformEKSNodeRole" {
  role       = aws_iam_role.kvvTestTerraformEKSNodeRole.name
  policy_arn = data.aws_iam_policy.amazonEKS_CNI_Policy.arn
}

