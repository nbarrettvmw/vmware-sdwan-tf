# Ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret
subscription_id = ""
client_id       = ""
client_secret   = ""
tenant_id       = ""

# env_name is a prefix used for the Azure entity names
env_name = "vmw-sdwan-ncus-test"
# Azure region to deploy into
location = "northcentralus"

# Network to be used for the dedicated sample VNet
network_cidr = "100.66.16.0/21"

# Local SSH username for the VCE
ssh_admin_username = ""
# Path to the SSH public key file for the VCE
ssh_keyfile = "~/.ssh/id_rsa.pub"

# URL of the VMware SD-WAN orchestrator; DO NOT include the https:// part of URL
vco_url = ""
# The VCE's activation key
vce_activation_key = ""
# The VCE size
# Valid options are: Standard_D2d_v4, Standard_D4d_v4, Standard_D8d_v4
vce_vm_size = "Standard_D2d_v4"
