resource "aws_vpc" "main" {
  cidr_block           = var.vpc_configs.cidr_block
  instance_tenancy     = var.vpc_configs.instance_tenancy
  enable_dns_hostnames = var.vpc_configs.enable_dns_hostnames

  tags = local.vpc_name
}