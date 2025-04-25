module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr
  azs  = var.aws_azs

  public_subnets = var.aws_public_subnet_cidr

  private_subnets      = []
  enable_private_subnet = false
  enable_nat_gateway    = false

  enable_dns_hostnames = true

  tags               = var.resource_tags
  public_subnet_tags = var.resource_tags
}
