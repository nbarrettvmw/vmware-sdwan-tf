resource "azurerm_resource_group" "tf_rg" {
  name     = "${var.env_name}-rg"
  location = var.location
}

module "sdwan_velonet" {
  source = "./velonet"
  providers = {
    azurerm = azurerm
  }
  name            = var.env_name
  location        = var.location
  cidr            = var.network_cidr
  activation_code = var.vce_activation_key
  admin_username  = var.ssh_admin_username
  ssh_key         = local.ssh_key
  vco_url         = var.vco_url
  vm_size         = var.vce_vm_size
  rg_name         = azurerm_resource_group.tf_rg.name
}
