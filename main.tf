module "network" {
  source      = "./modules/3-tier-network"
  vpc_configs = var.vpc_configs
}