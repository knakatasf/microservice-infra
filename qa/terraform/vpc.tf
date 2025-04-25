module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr
  azs  = var.aws_azs

  private_subnets = []
  public_subnets  = var.aws_public_subnet_cidr  # Internet Gateway is created automatically by VPC

  enable_dns_hostnames = true
  
  public_subnet_tags  = var.resource_tags
  tags                = var.resource_tags
}