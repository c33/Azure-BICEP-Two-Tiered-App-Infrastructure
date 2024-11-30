param p_nsg_name string
param p_global_location string

resource Default_NSG 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: '${p_nsg_name}-nsg'
  location: p_global_location
}

output NSG_ID string = Default_NSG.id
