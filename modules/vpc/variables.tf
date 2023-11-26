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