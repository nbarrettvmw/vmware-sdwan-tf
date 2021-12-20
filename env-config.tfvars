# Ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret
subscription_id = ""
client_id = ""
client_secret = ""
tenant_id = ""

# env_name is a prefix used for the Azure entity names
env_name = "vmw-sdwan-ncus-env"
# name of the Azure resource group to deploy into
rg_name = "my-sdwan-rg"
# Azure region to deploy into
location = "northcentralus"

# Network to be used for the dedicated VNet
network_cidr = "100.66.0.0/21"

# Username for the VCE
ssh_admin_username = ""
# Path to the SSH public key file for the VCE
ssh_keyfile = "~/.ssh/id_rsa.pub"

# DO NOT include the https:// part of URL
vco_url = ""
# This edge MUST have GE2 as a DHCP WAN and GE3 as a routed DHCP LAN
vce_activation_key = ""
vce_vm_size = "Standard_DS3_v2"
