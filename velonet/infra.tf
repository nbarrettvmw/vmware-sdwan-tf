terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
}

locals {
  # allow for up to 8 subnets in the VNet (using 3 bits for subnet)
  # we only use 2 but leave subnets for extending
  cidr_split = cidrsubnets(var.cidr, 3, 3)

  cidr_dmz  = element(local.cidr_split, 0)
  cidr_priv = element(local.cidr_split, 1)

  vce_ip_priv = cidrhost(local.cidr_priv, 10)
}

resource "azurerm_virtual_network" "tf_vnet" {
  name                = "${var.name}-vnet"
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = [var.cidr]
}

resource "azurerm_subnet" "tf_vnet_sn_dmz" {
  name                 = "${var.name}-vnet-sn-dmz"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.tf_vnet.name
  address_prefixes     = [local.cidr_dmz]
}

resource "azurerm_subnet" "tf_vnet_sn_priv" {
  name                 = "${var.name}-vnet-sn-priv"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.tf_vnet.name
  address_prefixes     = [local.cidr_priv]
}

resource "azurerm_route_table" "tf_rt_dmz" {
  name                = "${var.name}-rt-dmz"
  location            = var.location
  resource_group_name = var.rg_name

  route {
    name           = "local"
    address_prefix = var.cidr
    next_hop_type  = "vnetlocal"
  }

  route {
    name           = "Internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
}

resource "azurerm_route_table" "tf_rt_priv" {
  name                = "${var.name}-rt-priv"
  location            = var.location
  resource_group_name = var.rg_name

  route {
    name           = "local"
    address_prefix = var.cidr
    next_hop_type  = "vnetlocal"
  }

  route {
    name                   = "default"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = local.vce_ip_priv
  }
}

resource "azurerm_subnet_route_table_association" "tf_sn_rt_assoc_dmz" {
  subnet_id      = azurerm_subnet.tf_vnet_sn_dmz.id
  route_table_id = azurerm_route_table.tf_rt_dmz.id
}

resource "azurerm_subnet_route_table_association" "tf_sn_rt_assoc_priv" {
  subnet_id      = azurerm_subnet.tf_vnet_sn_priv.id
  route_table_id = azurerm_route_table.tf_rt_priv.id
}
