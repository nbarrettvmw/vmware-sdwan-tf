# VMware SD-WAN Virtual Edge Deployment into Azure via Terraform
This repository is a sample Terraform script to deploy a virtual SD-WAN edge along with other necessary Azure objects. 

See the `File Descriptions` section below for more information on what would be used out of this code when implementing yourself.

## Basic Usage
1. Clone this repository - `git clone https://github.com/nbarrettvmw/vmware-sdwan-tf`
2. Initialize the terraform environment - `terraform init`
3. Configure an SD-WAN virtual edge in your VCO
    - GE1:
        - Switched VLAN 1 access
        - Dummy IP address assigned on VLAN 1 (i.e. 169.254.10.10/32)
    - GE2:
        - Routed
        - WAN overlay enabled and set to auto-detect
        - Acquire IP via DHCP
    - GE3:
        - Routed
        - WAN overlay disabled
        - Acquire IP via DHCP
4. Duplicate the sample tfvars file - `cp env-config.tfvars my-env.tfvars`
5. Configure `my-env.tfvars` accordingly
6. Run `terraform apply -var-file=my-env.tfvars` to deploy the sample environment

## Files
`velonet/vce.tf` shows the bulk of the SD-WAN -specific setup. It instantiates the NICs, the WAN security group, a public IP, and the SD-WAN virtual appliance itself. It also contains the local variables specific to the SD-WAN edge implementation. This file is the primary reference for how to instantiate a SD-WAN edge. `velonet/templates/vce_userdata.yml` is used by this script as the VCE cloud-init userdata template.

`vars.tf` has descriptions of all of the required inputs for the sample.

`env-config.tfvars` is a sample tfvars file to copy and use for a specific deployment.

`main.tf` shows an example instantiation of the `velonet` module.

`velonet/infra.tf` is the Azure VNet setup that supports the sample topology. It instantiates a VNet, 2 subnets and 2 route tables. It also contains the local variables specific to this sample deployment.

## Sample Explanation
- Create a VNet with the specified CIDR range in a given region
- Create subnets
    - LAN 
    - DMZ
- Create route tables
    - LAN: default route pointing at the SD-WAN LAN IP
    - DMZ: only routes to the Internet for the appliance to form tunnels
- Create an Azure public IP to use for the SD-WAN GE2 interface
- Create a WAN NSG to permit SSH, SNMP, and VCMP
- Create dummy GE1, WAN, and LAN NICs
- Create the SD-WAN appliance