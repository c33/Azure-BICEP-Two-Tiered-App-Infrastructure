param p_VNET_Name string
param p_global_location string
param p_VNET_AddressPrefixes string
param p_Subnets {
  name : string
  address_prefix : string
}[]

param p_Default_NSG_ID string

resource VirtualNetwork 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: p_VNET_Name
  location: p_global_location
  properties: {
    addressSpace: {
      addressPrefixes: [
        p_VNET_AddressPrefixes
      ]
    }
    subnets: [for subnet in p_Subnets: {
        name: subnet.name
        properties: {
          addressPrefix: subnet.address_prefix
          networkSecurityGroup: (subnet.name != 'AzureBastionSubnet')  ?  { id: p_Default_NSG_ID } : null 
        }
      }  
    ]
  }

  resource subnets_list 'subnets' existing = [for subnet in p_Subnets: {
    name: subnet.name
  }]
}

output deployed_subnets object = toObject(VirtualNetwork.properties.subnets, entry => entry.name)

