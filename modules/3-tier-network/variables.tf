variable "vpc_configs" {
  description = <<DESCRIPTION
  cidr_block = (Optional) The IPv4 CIDR block for the VPC.
  instance_tenancy = (Optional) A tenancy option for instances launched into the VPC. Default is `default`
  enable_dns_hostnames = (Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults to false.
  DESCRIPTION
  type = object({
    cidr_block           = string
    instance_tenancy     = string
    enable_dns_hostnames = bool
  })
  default = {
    cidr_block           = "10.0.0.0/16"
    instance_tenancy     = "default"
    enable_dns_hostnames = false
  }
}

variable "public_subnet_configs" {
  description = <<DESCRIPTION
  cidr_block = (Optional) The IPv4 CIDR block for the subnet.
  availability_zone = (Optional) AZ for the subnet.
  map_public_ip_on_launch = (Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is `false`.
  Name = (Optional) Name tag to assign to the subnet.
  DESCRIPTION
  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    Name                    = string
  }))
  default = {
    az1 = { cidr_block = "10.0.0.0/24", availability_zone = "us-east-1a", map_public_ip_on_launch = true, Name = "public-subnet-az1" }
  }
}

variable "public_route_table_configs" {
  description = <<DESCRIPTION
  cidr_block = (Required) The CIDR block of the route.
  Name = (Optional) Name tag to assign to the route table.
  DESCRIPTION
  type        = map(string)
  default     = { cidr_block = "0.0.0.0/0", Name = "public-route-table" }
}