# Azure-BICEP-Two-Tiered-App-Infrastructure
Sample architecture to deploy an Azure VM and SQL DB on logical SQL server, with Bastion Host for VM access, using Microsoft BICEP. 
This was developed as a rudimentary architecture for a college project and should not be considered enterprise-ready, the author accepts no liability for any IT incidents or damages resulting from its deployment.

**#Instructions For Use**

1. Deploy the resource group at a subscription scope using the **0_ResourceGroup_Provisioner** directory to deploy a resource group called **"bicep-eun-t-iaas-rg-001"**

2. After the resource group is deployed, the architecture can be deployed with one or five VMs by using
  az deployment group create --resource-group "bicep-eun-t-iaas-rg-001" --template-file 0.main.bicep --parameters 0.main.bicepparam
  from within the **1_single_vm_iaas_architecture_provisioner_bicep** or **2_multi_vm_iaas_architecture_provisioner_bicep** directories.

   
