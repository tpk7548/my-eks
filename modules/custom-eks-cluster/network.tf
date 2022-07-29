resource "aws_cloudformation_stack" "kvvTerraformTestEksCloudFormationStack" {
  name = "kvvTerraformTestEksCloudFormationStack"

  parameters = {
    VpcBlock = var.vpcCidrBlock
    Subnet01Block = var.subnetList[0]
    Subnet02Block = var.subnetList[1]
    Subnet03Block = var.subnetList[2]
  }

  template_body = file(format("%s/%s", path.module, "cloudformation/amazon-eks-vpc-sample.yaml"))
}

locals {
  nodeGroupSubnetsAwsIdsList = split(",", aws_cloudformation_stack.kvvTerraformTestEksCloudFormationStack.outputs["SubnetIds"])
}