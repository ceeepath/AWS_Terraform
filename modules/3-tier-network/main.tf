# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_configs.cidr_block
  instance_tenancy     = var.vpc_configs.instance_tenancy
  enable_dns_hostnames = var.vpc_configs.enable_dns_hostnames

  tags = {
    Name = "dev-vpc"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "dev-gateway"
  }
}

# Attach Internet Gateway to VPC
resource "aws_internet_gateway_attachment" "main" {
  internet_gateway_id = aws_internet_gateway.main.id
  vpc_id              = aws_vpc.main.id
}

# Create Public Subnets
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_configs.cidr_block
  availability_zone = var.public_subnet_configs.availability_zone
  map_public_ip_on_launch = var.public_subnet_configs.map_public_ip_on_launch

  tags = {
    Name = var.public_subnet_configs.Name
  }
}

