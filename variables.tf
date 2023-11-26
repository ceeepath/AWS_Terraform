variable "vpc_configs" {
  type = object({
    cidr_block = string
    instance_tenancy = string
    enable_dns_hostnames = bool 
  })
}