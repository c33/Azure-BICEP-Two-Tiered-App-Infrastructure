param p_bastion_pip_allocation_method string

param p_bastion_name string
param p_global_location string
param p_bastion_subnet_id string

resource BastionPublicIP 'Microsoft.Network/publicIPAddresses@2024-01-01' = {
  name: '${p_bastion_name}-bast-pip'
  location: p_global_location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAllocationMethod: p_bastion_pip_allocation_method
  }
}

resource BastionHost 'Microsoft.Network/bastionHosts@2023-11-01' = {
  name: '${p_bastion_name}-bast'
  location: p_global_location
  sku: {
    name: 'Standard'
  }
  properties: {
    ipConfigurations: [
      {
        name: '${p_bastion_name}-bast-ipconfig'
        properties: {
          publicIPAddress: {
            id: BastionPublicIP.id
          }
          subnet: {
            id: p_bastion_subnet_id
          }
        }
      }
    ]
  }
}
