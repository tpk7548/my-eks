resource "aws_vpc" "main" {
  cidr_block       = var.vpcCidrBlock
  instance_tenancy = "default"

  tags = {
    Name = "kvv-EKS-VPC"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "publicSubnet" {
  for_each = var.subnetsMap
 
  availability_zone_id    = element(data.aws_availability_zones.available.zone_ids, tonumber(each.value.azNumber))
  cidr_block              = each.value.cidr
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet-${each.key}"
  }
}

locals {
  publicSubnetsIds = [ for it in aws_subnet.publicSubnet: it.id ]
}

resource "aws_internet_gateway" "vpcIgw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "kvv-EKS-vpcIgw"
  }
}

resource "aws_route_table" "routeTable" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpcIgw.id
  }

  tags = {
    Name = "kvv-EKS-routeTable"
  }
}

resource "aws_route_table_association" "rtAssociation" {
  for_each = var.subnetsMap

  subnet_id      = aws_subnet.publicSubnet[each.key].id
  route_table_id = aws_route_table.routeTable.id
}