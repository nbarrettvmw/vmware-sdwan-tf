output "lan_subnet_id" {
  value = azurerm_subnet.tf_vnet_sn_priv.id
  description = "Azure ID of the LAN subnet"
}

output "lan_cidr" {
  value = local.cidr_priv
  description = "CIDR prefix of the LAN subnet"
}

output "vce_lan_ip" {
  value = azurerm_network_interface.tf_nic_vce_lan.private_ip_address
  description = "IP address of the VCE LAN interface"
}