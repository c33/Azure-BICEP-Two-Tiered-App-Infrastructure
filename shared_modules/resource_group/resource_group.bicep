targetScope = 'subscription'

param p_RG_Name string
param p_RG_Location string
param p_RG_ManagedBy string
param p_RG_Properties object

resource symbolicname 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: p_RG_Name
  location: p_RG_Location
  managedBy: p_RG_ManagedBy
  properties: p_RG_Properties
}
