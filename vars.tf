# Service principal for Azure
variable "subscription_id" {
  type = string
  description = "Subscription ID for the Azure account"
}
variable "client_id" {
  type = string
  description = "Client ID for the Azure service principal"
}
variable "client_secret" {
  type = string
  description = "Client secret for the Azure service principal"
}
variable "tenant_id" {
  type = string
  description = "Azure AD tenant ID"
}

variable "env_name" {
  type = string
  description = "Short name used as a prefix for object names"
}

variable "location" {
  type = string
  description = "Azure region for the environment i.e. northcentralus"
}

variable "network_cidr" {
  type = string
  description = "CIDR block for the VNet"
}

variable "vco_url" {
  type = string
  description = "URL of the VCO to activate against"
}

variable "vce_activation_key" {
  type = string
  description = "Activation key for the VCE"
}

variable "vce_vm_size" {
  type = string
  description = "Azure VM model for the VCE. Check VMware documentation."
}

variable "ssh_keyfile" {
  type = string
  description = "Path to the key file containing the desired public key"
}

variable "ssh_admin_username" {
  type = string
  description = "Initial administrator username for the VCE"
}
