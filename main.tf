module "network" {
  source                     = "./modules/3-tier-network"
  vpc_configs                = var.vpc_configs
  public_subnet_configs      = var.public_subnet_configs
  public_route_table_configs = var.public_route_table_configs
  private_subnet_configs     = var.private_subnet_configs
}